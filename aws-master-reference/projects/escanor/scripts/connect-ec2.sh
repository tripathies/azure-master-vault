#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TF_DIR="${SCRIPT_DIR}/../infra/terraform"
REGION="${AWS_REGION:-$(terraform -chdir="${TF_DIR}" output -raw aws_region)}"
INSTANCE_ID="$(terraform -chdir="${TF_DIR}" output -raw ec2_instance_id)"

echo "Starting Session Manager shell for ${INSTANCE_ID} in ${REGION}."
aws ssm start-session --target "${INSTANCE_ID}" --region "${REGION}"
