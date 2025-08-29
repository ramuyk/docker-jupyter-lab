#!/usr/bin/env bash
set -euo pipefail

HOME_DIR="/root"
WORK_DIR="${HOME_DIR}/work"

# Garante que os diretórios existam
mkdir -p "${WORK_DIR}"
cd "${WORK_DIR}"

# Run whatever was passed in CMD
exec "$@"

