#!/usr/bin/env bash
set -euo pipefail

NB_USER="${NB_USER:-jovyan}"
NB_UID="${NB_UID:-1000}"
NB_GID="${NB_GID:-1000}"
HOME_DIR="/home/${NB_USER}"
WORK_DIR="${HOME_DIR}/work"

# Garante que os diretórios existam
mkdir -p "${WORK_DIR}"

# Se não for gravável pelo jovyan, corrige dono/perms (inclui bind mount)
if ! su -s /bin/bash -c "test -w '${WORK_DIR}'" "${NB_USER}" 2>/dev/null; then
  echo "[start] fixing ownership of ${HOME_DIR} and ${WORK_DIR} to ${NB_UID}:${NB_GID}"
  chown -R "${NB_UID}:${NB_GID}" "${HOME_DIR}" || true
  chmod -R u+rwX "${HOME_DIR}" || true
fi

# Sobe o JupyterLab como jovyan
exec gosu "${NB_UID}:${NB_GID}" "$@"
