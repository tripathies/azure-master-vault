#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${SCRIPT_DIR}/.."
APP_DIR="${PROJECT_DIR}/app"
TF_DIR="${PROJECT_DIR}/infra/terraform"

python3 -m venv "${PROJECT_DIR}/.venv"
"${PROJECT_DIR}/.venv/bin/python" -m pip install --upgrade pip
"${PROJECT_DIR}/.venv/bin/python" -m pip install -r "${APP_DIR}/requirements.txt"
cd "${APP_DIR}"
"${PROJECT_DIR}/.venv/bin/python" -m compileall -q app.py tests ../scripts
bash -n ../scripts/*.sh
"${PROJECT_DIR}/.venv/bin/python" -m unittest discover -s tests -v

terraform -chdir="${TF_DIR}" fmt -check -recursive
terraform -chdir="${TF_DIR}" init -backend=false -input=false
terraform -chdir="${TF_DIR}" validate
