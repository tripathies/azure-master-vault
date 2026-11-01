#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TF_DIR="${SCRIPT_DIR}/../infra/terraform"
REGION="${AWS_REGION:-$(terraform -chdir="${TF_DIR}" output -raw aws_region)}"
INSTANCE_ID="$(terraform -chdir="${TF_DIR}" output -raw ec2_instance_id)"
DB_HOST="$(terraform -chdir="${TF_DIR}" output -raw rds_endpoint)"

echo "Forwarding private RDS endpoint ${DB_HOST}:5432 to localhost:15432."
echo "Keep this terminal open while running bootstrap-db-user.py."
aws ssm start-session \
  --target "${INSTANCE_ID}" \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters "{\"host\":[\"${DB_HOST}\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"15432\"]}" \
  --region "${REGION}"
