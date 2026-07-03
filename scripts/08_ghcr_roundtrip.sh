#!/usr/bin/env bash
set -euo pipefail

# Optional: source .secrets for interactive runs
if [[ -f ".secrets" ]]; then
  # shellcheck disable=SC1091
  source ".secrets"
fi

if [[ -z "${GHCR_USERNAME:-}" || -z "${GHCR_PAT:-}" ]]; then
  echo "GHCR_USERNAME and GHCR_PAT must be set in .secrets or environment."
  exit 1
fi

make package
make ghcr-login
make ghcr-push
make ghcr-pull
make ghcr-show-chart
make ghcr-show-values