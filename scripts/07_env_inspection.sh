#!/usr/bin/env bash
set -euo pipefail

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

pause() {
  local CYAN="\033[1;36m"
  local RESET="\033[0m"

  echo
  # -e lets echo interpret \033 as an escape for color
  echo -e "${CYAN}Press ENTER to run the next step...${RESET}"
  read -r _
  echo
}
# Exercise 07: Environment and Troubleshooting
# Script: 07_env_inspection.sh
# Purpose:
#   - Inspect Helm environment variables and paths.
#   - List dev releases.
#   - Show dev release status.
#   - Run tests for dev release.
# How to check output:
#   - Review helm env output for cache/config/data directories.
#   - Check helm list/status output for dev release health.
#   - Examine test logs for validation of service readiness.
echo -e "${YELLOW}[07] Environment and troubleshooting"
make -f Makefile_Helm_Packaging_Releasing print_env_inspection_purpose
pause
echo -e "${GREEN} Step 1: Show Helm environment variables"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-env-variables

echo -e "${GREEN} Step 2: List dev releases"
pause
make -f Makefile_Helm_Packaging_Releasing helm-list-dev-releases-in-namespace

echo -e "${GREEN} Step 3: Show dev release status"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-status-dev-release-in-namespace

echo -e "${YELLOW}[07] Completed. Inspect status and test logs for any issues."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause