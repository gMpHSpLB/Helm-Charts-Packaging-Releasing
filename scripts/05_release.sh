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
# Exercise 05: Release Management (dev/staging/prod)
# Script: 05_release.sh
# Purpose:
#   - Install or upgrade dev, staging, and prod releases.
#   - Inspect dev release history, manifest, and values.
#   - Verify deployments in each environment via kubectl.
# How to check output:
#   - Use kubectl to list deployments in dev/staging/prod namespaces.
#   - Examine helm history, helm get manifest, and helm get values output.

echo -e "${YELLOW}[05] Release management (dev/staging/prod)"
make -f Makefile_Helm_Packaging_Releasing print_release_management_purpose
pause
echo -e "${GREEN} Step 1: Install/upgrade dev release"
pause
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace

echo -e "${GREEN} Step 2: Install/upgrade staging release"
pause
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-staging-release-in-namespace

echo -e "${GREEN} Step 3: Install/upgrade prod release"
pause
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-prod-release-in-namespace

echo -e "${GREEN} Step 4: Show dev release history"
pause
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo -e "${GREEN} Step 5: Get dev release manifest"
pause
make -f Makefile_Helm_Packaging_Releasing helm-get-manifest-dev-release-in-namespace

echo -e "${GREEN} Step 6: Get dev release values"
pause
make -f Makefile_Helm_Packaging_Releasing helm-get-values-dev-release-in-namespace

echo -e "${YELLOW}[05] Completed. Use 'kubectl get deploy -n catalog-dev' etc. to verify releases."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause
