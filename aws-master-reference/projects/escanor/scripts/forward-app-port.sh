#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TF_DIR="${SCRIPT_DIR}/../infra/terraform"
REGION="${AWS_REGION:-$(terraform -chdir="${TF_DIR}" output -raw aws_region)}"
INSTANCE_ID="$(terraform -chdir="${TF_DIR}" output -raw ec2_instance_id)"

echo "Forwarding EC2 port 8080 to http://127.0.0.1:8080. Keep this session open."
aws ssm start-session \
  --target "${INSTANCE_ID}" \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}' \
  --region "${REGION}"
