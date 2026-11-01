"""Bootstrap the IAM-authenticated application DB role over an SSM port forward."""
from __future__ import annotations

import argparse
import json
import sys

import boto3
import psycopg
from botocore.exceptions import BotoCoreError, ClientError
from psycopg import sql


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--region", required=True)
    parser.add_argument("--secret-arn", required=True)
    parser.add_argument("--local-port", type=int, default=15432)
    parser.add_argument("--database", default="escanor")
    parser.add_argument("--app-user", default="escanor_app")
    parser.add_argument(
        "--ssl-root-cert",
        default="~/.aws/rds-global-bundle.pem",
        help="Path to the AWS RDS CA bundle used to verify the DB server certificate.",
    )
    args = parser.parse_args()
    from pathlib import Path
    ca_bundle = Path(args.ssl_root_cert).expanduser()
    if not ca_bundle.is_file():
        parser.error(f"RDS CA bundle not found: {ca_bundle}")

    secret_response = boto3.client(
        "secretsmanager", region_name=args.region
    ).get_secret_value(SecretId=args.secret_arn)
    secret = json.loads(secret_response["SecretString"])

    with psycopg.connect(
        host="127.0.0.1",
        port=args.local_port,
        dbname=args.database,
        user=secret["username"],
        password=secret["password"],
        sslmode="verify-ca",
        sslrootcert=str(ca_bundle),
        connect_timeout=5,
    ) as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT 1 FROM pg_roles WHERE rolname = %s", (args.app_user,)
            )
            if cursor.fetchone() is None:
                cursor.execute(
                    sql.SQL("CREATE ROLE {} LOGIN").format(
                        sql.Identifier(args.app_user)
                    )
                )
            cursor.execute(
                sql.SQL("GRANT rds_iam TO {}").format(
                    sql.Identifier(args.app_user)
                )
            )
            cursor.execute(
                sql.SQL("GRANT CONNECT ON DATABASE {} TO {}").format(
                    sql.Identifier(args.database),
                    sql.Identifier(args.app_user),
                )
            )
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS public.lab_notes (
                    id BIGSERIAL PRIMARY KEY,
                    note VARCHAR(500) NOT NULL,
                    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
                )
                """
            )
            cursor.execute(
                sql.SQL("GRANT USAGE ON SCHEMA public TO {}").format(
                    sql.Identifier(args.app_user)
                )
            )
            cursor.execute(
                sql.SQL("GRANT SELECT, INSERT ON public.lab_notes TO {}").format(
                    sql.Identifier(args.app_user)
                )
            )
            cursor.execute(
                sql.SQL("GRANT USAGE, SELECT ON SEQUENCE public.lab_notes_id_seq TO {}").format(
                    sql.Identifier(args.app_user)
                )
            )

    print(f"Created/verified IAM-authenticated DB role: {args.app_user}")
    print("The EC2 instance role can connect with rds-db:connect; no DB password is stored on EC2.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (BotoCoreError, ClientError, KeyError, ValueError, psycopg.Error) as exc:
        print(f"Database bootstrap failed: {type(exc).__name__}: {exc}", file=sys.stderr)
        raise SystemExit(1)
