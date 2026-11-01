#!/usr/bin/env bash
set -euo pipefail

REGION="${AWS_REGION:-ap-south-1}"
EXPECTED_ACCOUNT="${EXPECTED_AWS_ACCOUNT_ID:-}"

for command in aws terraform python3; do
  command -v "${command}" >/dev/null 2>&1 || {
    echo "Required command not found: ${command}" >&2
    exit 1
  }
done

IDENTITY="$(aws sts get-caller-identity --region "${REGION}" --output json)"
ACCOUNT_ID="$(python3 -c 'import json,sys; print(json.load(sys.stdin)["Account"])' <<< "${IDENTITY}")"
ARN="$(python3 -c 'import json,sys; print(json.load(sys.stdin)["Arn"])' <<< "${IDENTITY}")"

if [[ -n "${EXPECTED_ACCOUNT}" && "${ACCOUNT_ID}" != "${EXPECTED_ACCOUNT}" ]]; then
  echo "Wrong AWS account. Expected ${EXPECTED_ACCOUNT}, authenticated to ${ACCOUNT_ID}." >&2
  exit 2
fi

printf 'AWS account : %s\nAWS identity: %s\nAWS Region  : %s\n' "${ACCOUNT_ID}" "${ARN}" "${REGION}"
terraform version
python3 --version
