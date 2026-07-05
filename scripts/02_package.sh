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
# Exercise 02: Package
# Script: 02_package.sh
# Purpose:
#   - Package the chart into a versioned .tgz file.
# How to check output:
#   - Verify dist/catalog-service-<version>.tgz exists.
echo -e "${YELLOW}[02] Package chart"
make -f Makefile_Helm_Packaging_Releasing print_package_purpose
pause
echo -e "${GREEN} Step 1: Package chart (helm-package-chart-with-version)"
pause
make -f Makefile_Helm_Packaging_Releasing helm-package-chart-with-version

echo -e "${YELLOW}[02] Completed. Check dist/ for the .tgz file."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause