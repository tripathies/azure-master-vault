"""Small Escanor app: EC2 instance role, RDS IAM auth and S3 object storage."""
from __future__ import annotations

import logging
import os
import re
from typing import Any

import boto3
import psycopg
from botocore.exceptions import BotoCoreError, ClientError
from flask import Flask, jsonify, render_template, request
from psycopg.rows import dict_row


def required_env(name: str) -> str:
    value = os.environ.get(name, "").strip()
    if not value:
        raise RuntimeError(f"Required environment variable {name} is not set")
    return value


def get_s3_client():
    return boto3.client("s3", region_name=required_env("AWS_REGION"))


def get_db_connection():
    """Connect using a short-lived RDS IAM token and TLS certificate validation."""
    region = required_env("AWS_REGION")
    host = required_env("DB_HOST")
    port = int(os.environ.get("DB_PORT", "5432"))
    database = required_env("DB_NAME")
    username = required_env("DB_USER")
    ca_bundle = os.environ.get(
        "RDS_CA_BUNDLE", "/etc/pki/tls/certs/rds-global-bundle.pem"
    )
    token = boto3.client("rds", region_name=region).generate_db_auth_token(
        DBHostname=host, Port=port, DBUsername=username, Region=region
    )
    return psycopg.connect(
        host=host,
        port=port,
        dbname=database,
        user=username,
        password=token,
        sslmode="verify-full",
        sslrootcert=ca_bundle,
        connect_timeout=5,
        row_factory=dict_row,
    )


def valid_object_name(name: str) -> bool:
    """Allow one safe file name; callers cannot choose arbitrary S3 prefixes."""
    if not isinstance(name, str) or not name or len(name) > 120:
        return False
    if name in {".", ".."} or ".." in name or name.startswith("/"):
        return False
    return bool(re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._-]*", name))


def create_app() -> Flask:
    app = Flask(__name__, template_folder="templates")
    app.config["MAX_CONTENT_LENGTH"] = 64 * 1024
    app.logger.setLevel(logging.INFO)

    @app.get("/")
    def index():
        return render_template("index.html")

    @app.get("/healthz")
    def healthz():
        # Liveness remains available even when RDS or S3 is impaired.
        return jsonify(status="ok", service="escanor-learning-app")

    @app.get("/api/diagnostics")
    def diagnostics():
        result: dict[str, Any] = {
            "application": "ok",
            "database": "not-tested",
            "object_storage": "not-tested",
            "region": os.environ.get("AWS_REGION", "not-configured"),
        }
        try:
            with get_db_connection() as connection:
                row = connection.execute(
                    "SELECT current_user AS database_user, current_database() AS database_name, now() AS database_time"
                ).fetchone()
                result["database"] = "ok"
                result["database_detail"] = {
                    "user": row["database_user"],
                    "database": row["database_name"],
                    "server_time": row["database_time"].isoformat(),
                }
            bucket = required_env("S3_BUCKET")
            response = get_s3_client().list_objects_v2(
                Bucket=bucket, Prefix="uploads/", MaxKeys=1
            )
            result["object_storage"] = "ok"
            result["bucket"] = bucket
            result["s3_endpoint_path"] = "VPC S3 gateway endpoint"
            result["sample_object_count"] = response.get("KeyCount", 0)
            return jsonify(result)
        except (RuntimeError, BotoCoreError, ClientError, psycopg.Error) as exc:
            app.logger.exception("Diagnostics check failed")
            result["status"] = "degraded"
            result["error_type"] = type(exc).__name__
            return jsonify(result), 503

    @app.get("/api/notes")
    def list_notes():
        try:
            with get_db_connection() as connection:
                rows = connection.execute(
                    "SELECT id, note, created_at FROM public.lab_notes ORDER BY id DESC LIMIT 50"
                ).fetchall()
            return jsonify(notes=[
                {
                    "id": row["id"],
                    "note": row["note"],
                    "created_at": row["created_at"].isoformat(),
                }
                for row in rows
            ])
        except (RuntimeError, psycopg.Error) as exc:
            app.logger.exception("Database read failed")
            return jsonify(error="Database is not ready", detail=type(exc).__name__), 503

    @app.post("/api/notes")
    def create_note():
        payload = request.get_json(silent=True) or {}
        note = payload.get("note")
        if not isinstance(note, str) or not note.strip() or len(note.strip()) > 500:
            return jsonify(error="note must contain 1 to 500 characters"), 400
        try:
            with get_db_connection() as connection:
                row = connection.execute(
                    "INSERT INTO public.lab_notes (note) VALUES (%s) RETURNING id, note, created_at",
                    (note.strip(),),
                ).fetchone()
            return jsonify(
                id=row["id"],
                note=row["note"],
                created_at=row["created_at"].isoformat(),
            ), 201
        except (RuntimeError, psycopg.Error) as exc:
            app.logger.exception("Database write failed")
            return jsonify(error="Database write failed", detail=type(exc).__name__), 503

    @app.get("/api/objects")
    def list_objects():
        try:
            bucket = required_env("S3_BUCKET")
            response = get_s3_client().list_objects_v2(
                Bucket=bucket, Prefix="uploads/", MaxKeys=100
            )
            objects = [
                {
                    "key": item["Key"],
                    "size_bytes": item["Size"],
                    "last_modified": item["LastModified"].isoformat(),
                }
                for item in response.get("Contents", [])
            ]
            return jsonify(bucket=bucket, objects=objects)
        except (RuntimeError, BotoCoreError, ClientError) as exc:
            app.logger.exception("S3 list failed")
            return jsonify(error="S3 list failed", detail=type(exc).__name__), 503

    @app.get("/api/object-versions")
    def list_object_versions():
        name = request.args.get("name", "")
        if not valid_object_name(name):
            return jsonify(error="name must be a simple file name"), 400
        key = f"uploads/{name}"
        try:
            bucket = required_env("S3_BUCKET")
            response = get_s3_client().list_object_versions(
                Bucket=bucket, Prefix=key
            )
            versions = [
                {
                    "version_id": item["VersionId"],
                    "is_latest": item["IsLatest"],
                    "last_modified": item["LastModified"].isoformat(),
                    "size_bytes": item["Size"],
                }
                for item in response.get("Versions", [])
                if item["Key"] == key
            ]
            delete_markers = [
                {
                    "version_id": item["VersionId"],
                    "is_latest": item["IsLatest"],
                    "last_modified": item["LastModified"].isoformat(),
                    "delete_marker": True,
                }
                for item in response.get("DeleteMarkers", [])
                if item["Key"] == key
            ]
            return jsonify(key=key, versions=versions, delete_markers=delete_markers)
        except (RuntimeError, BotoCoreError, ClientError) as exc:
            app.logger.exception("S3 version listing failed")
            return jsonify(error="S3 version listing failed", detail=type(exc).__name__), 503

    @app.post("/api/objects")
    def upload_object():
        payload = request.get_json(silent=True) or {}
        name = payload.get("name")
        content = payload.get("content")
        if not valid_object_name(name):
            return jsonify(error="name must be a simple file name without path segments"), 400
        if not isinstance(content, str) or not content or len(content.encode("utf-8")) > 48 * 1024:
            return jsonify(error="content must contain 1 to 49152 UTF-8 bytes"), 400
        key = f"uploads/{name}"
        try:
            bucket = required_env("S3_BUCKET")
            get_s3_client().put_object(
                Bucket=bucket,
                Key=key,
                Body=content.encode("utf-8"),
                ContentType="text/plain; charset=utf-8",
            )
            return jsonify(bucket=bucket, key=key, stored=True), 201
        except (RuntimeError, BotoCoreError, ClientError) as exc:
            app.logger.exception("S3 upload failed")
            return jsonify(error="S3 upload failed", detail=type(exc).__name__), 503

    return app


app = create_app()
