#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TF_DIR="${PROJECT_DIR}/infra/terraform"
REGION="${AWS_REGION:-ap-south-1}"
ENVIRONMENT="${TF_VAR_environment:-lab}"

for command in aws terraform; do
  command -v "${command}" >/dev/null 2>&1 || {
    echo "Required command not found: ${command}" >&2
    exit 1
  }
done

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text --region "${REGION}")"
SUFFIX="$(od -An -N4 -tx1 /dev/urandom | tr -d ' \n')"
BUCKET="escanor-tfstate-${ACCOUNT_ID}-${REGION}-${SUFFIX}"
BACKEND_FILE="${TF_DIR}/backend.hcl"

if [[ -e "${BACKEND_FILE}" ]]; then
  echo "Backend configuration already exists: ${BACKEND_FILE}" >&2
  echo "Inspect and reuse the existing bucket. Do not create a second state bucket." >&2
  exit 1
fi

if [[ "${REGION}" == "us-east-1" ]]; then
  aws s3api create-bucket --bucket "${BUCKET}" --region "${REGION}"
else
  aws s3api create-bucket \
    --bucket "${BUCKET}" \
    --region "${REGION}" \
    --create-bucket-configuration "LocationConstraint=${REGION}"
fi

aws s3api put-public-access-block \
  --bucket "${BUCKET}" --region "${REGION}" \
  --public-access-block-configuration \
  'BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true'

aws s3api put-bucket-ownership-controls \
  --bucket "${BUCKET}" --region "${REGION}" \
  --ownership-controls 'Rules=[{ObjectOwnership=BucketOwnerEnforced}]'

aws s3api put-bucket-versioning \
  --bucket "${BUCKET}" --region "${REGION}" \
  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption \
  --bucket "${BUCKET}" --region "${REGION}" \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

POLICY_FILE="$(mktemp)"
trap 'rm -f "${POLICY_FILE}"' EXIT
cat > "${POLICY_FILE}" <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "DenyInsecureTransport",
    "Effect": "Deny",
    "Principal": "*",
    "Action": "s3:*",
    "Resource": [
      "arn:aws:s3:::${BUCKET}",
      "arn:aws:s3:::${BUCKET}/*"
    ],
    "Condition": { "Bool": { "aws:SecureTransport": "false" } }
  }]
}
EOF
aws s3api put-bucket-policy --bucket "${BUCKET}" --region "${REGION}" --policy "file://${POLICY_FILE}"

cat > "${BACKEND_FILE}" <<EOF
bucket       = "${BUCKET}"
key          = "escanor/${ENVIRONMENT}/terraform.tfstate"
region       = "${REGION}"
encrypt      = true
use_lockfile = true
EOF

chmod 0600 "${BACKEND_FILE}"
echo "Created private, encrypted and versioned Terraform state bucket: ${BUCKET}"
echo "Next: terraform -chdir=infra/terraform init -backend-config=backend.hcl"
