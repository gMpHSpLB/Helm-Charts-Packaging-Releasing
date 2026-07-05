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
# Exercise 03: Registry Operations

# Script: 03_registry_roundtrip.sh
# Purpose:
#   - Login to GHCR (OCI).
#   - Push the chart package to GHCR..
#   - Pull the chart package back by version.
#   - Show chart metadata and values from GHCR.
# What this proves:
#   - You can authenticate to an OCI registry.
#   - You can push versioned Helm chart artifacts to GHCR.
#   - You can pull a specific chart version back from GHCR into downloads/.
#   - Check GHCR UI for the published OCI artifact.
#   - Review helm show chart/values output from GHCR.
echo -e "${YELLOW}[03] Registry operations (GHCR roundtrip + repo commands)"
make -f Makefile_Helm_Packaging_Releasing print_registry_roundtrip_purpose
pause
echo -e "${GREEN} Step 1: Login to GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-oci-registry-login

echo -e "${GREEN} Step 2: Push chart package to GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-push-chart-packag-to-registry

echo -e "${GREEN} Step 3: Pull chart by version from GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-pull-chart-by-version-from-registry

echo -e "${YELLOW}[03] Completed. Check downloads/ for pulled charts and command output for repo operations."
pause
make -f Makefile_Helm_Packaging_Releasing helm-pull-chart-by-version-from-registry

echo -e "${GREEN} Step 4: Show chart metadata from GHCR"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-chart-metadata

echo -e "${GREEN} Step 5: Show default values from GHCR chart"
pause
make -f Makefile_Helm_Packaging_Releasing helm-show-chart-values

echo -e "${YELLOW}[03] Completed. Verify dist/ and downloads/ contents and GHCR UI."
pause
    # NOTE: 
        # 1. The targets helm-add-a-repo, helm-repo-update, and helm-search-repo
        # demonstrate classic HTTP Helm repositories, not OCI registries.

        # 2. In this lab we use GHCR as an OCI registry (helm registry login / helm push / helm pull),
        # so these repo commands are optional examples, not required for GHCR.

        # 3. helm repo add/update/search are for traditional Helm repos 
        # (for example, https://charts.bitnami.com/bitnami), which you are not using in this lab

echo "Optional: Step 6: Add a demo Helm repo"
pause
make -f Makefile_Helm_Packaging_Releasing helm-add-a-repo

echo "Optional: Step 7: Update repo cache"
make -f Makefile_Helm_Packaging_Releasing helm-repo-update

echo "Optional: Step 8: Search chart repo"
make -f Makefile_Helm_Packaging_Releasing helm-search-repo

echo " ==========================================================================================="
echo " ==========================================================================================="
pause