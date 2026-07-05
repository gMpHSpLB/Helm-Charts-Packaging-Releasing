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
# Exercise 04: Dependency Management
# Purpose:
#   - Add required chart repos (e.g., Bitnami).
#   - Update chart dependencies (Chart.yaml → Chart.lock).
#   - Build dependencies into charts/ subdirectory.
#   - Render dev manifests with dependencies included.
# How to check output:
#   - Confirm Chart.lock exists and is updated.
#   - Check charts/catalog-service/charts/ for dependency archives.
#   - Inspect template output to see dependency resources if applicable.

echo -e "${YELLOW}[04] Dependency management"
make -f Makefile_Helm_Packaging_Releasing print_dependencies_management_purpose
pause

echo -e "${GREEN} Step 0: Add Bitnami repo (needed for postgresql dependency)"
pause
make -f Makefile_Helm_Packaging_Releasing helm-add-a-repo

echo -e "${GREEN} Step 0.1: Update repo cache"
pause
make -f Makefile_Helm_Packaging_Releasing helm-repo-update

echo -e "${GREEN} Step 1: Update dependencies (helm-dependency-update-in-lockfile)"
pause
make -f Makefile_Helm_Packaging_Releasing helm-dependency-update-in-lockfile

echo -e "${GREEN} Step 2: Build dependencies from lockfile (helm-dependency-build-from-lockfile)"
pause
make -f Makefile_Helm_Packaging_Releasing helm-dependency-build-from-lockfile

echo -e "${GREEN} Step 3: Render dev manifests with dependencies (helm-template-dev)"
pause
make -f Makefile_Helm_Packaging_Releasing helm-template-dev

echo -e "${YELLOW}[04] Completed. Check Chart.lock and charts/ subdirectory for dependencies."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause