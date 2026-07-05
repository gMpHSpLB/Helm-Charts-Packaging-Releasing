#!/usr/bin/env bash
set -euo pipefail
pause() {
  local CYAN="\033[1;36m"
  local RESET="\033[0m"

  echo
  # -e lets echo interpret \033 as an escape for color
  echo -e "${CYAN}Press ENTER to run the step...${RESET}"
  read -r _
  echo
}
# GHCR roundtrip: package, login, push, pull, inspect

# Ensure .secrets is present if you rely on it
if [[ -f ".secrets" ]]; then
  # shellcheck disable=SC1091
  source ".secrets"
fi

if [[ -z "${GHCR_USERNAME:-}" || -z "${GHCR_PAT:-}" ]]; then
  echo "GHCR_USERNAME and GHCR_PAT must be set in .secrets or environment."
  exit 1
fi

# Script: 08_ghcr_roundtrip.sh
# Purpose:
#   - Package the chart.
#   - Login to GHCR.
#   - Push the chart to GHCR (OCI).
#   - Pull the chart back from GHCR.
#   - Show chart metadata and values from GHCR.
# How to check output:
#   - Confirm dist/ contains the packaged chart.
#   - Confirm downloads/ contains the pulled chart.
#   - Check GHCR UI for the published OCI artifact.
#   - Review helm show chart/values output from GHCR.
echo "[08] GHCR roundtrip (OCI registry workflow)"
pause
if [[ -f ".secrets" ]]; then
  # shellcheck disable=SC1091
  source ".secrets"
fi

if [[ -z "${GHCR_USERNAME:-}" || -z "${GHCR_PAT:-}" ]]; then
  echo "GHCR_USERNAME and GHCR_PAT must be set in .secrets or environment."
  exit 1
fi

echo "Step 1: Package chart"
pause
make -f Makefile_Helm_Packaging_Releasing helm-package-chart-with-version

echo "Step 2: Login to GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-oci-registry-login

echo "Step 3: Push chart package to GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-push-chart-packag-to-registry

echo "Step 4: Pull chart package from GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-pull-chart-by-version-from-registry

echo "Step 5: Show chart metadata from GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-chart-metadata

echo "Step 6: Show default values from GHCR chart"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-chart-values

echo "[08] Completed. Verify dist/ and downloads/ contents and GHCR UI."
pause
echo "GHCR roundtrip complete for chart ${PROJECT:-catalog-service} version ${CHART_VERSION:-0.1.0}."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause