#!/usr/bin/env bash
set -euo pipefail

# Exercise 03: Registry Operations

# Script: 03_registry_roundtrip.sh
# Purpose:
#   - Login to GHCR.
#   - Push the chart package.
#   - Pull the chart package back by version.
#   - Exercise Helm repo add/update/search commands.
# How to check output:
#   - Confirm downloads/ contains the pulled .tgz.
#   - Observe repo add/update/search output in the terminal.
echo "[03] Registry operations (GHCR roundtrip + repo commands)"

echo "Step 1: Login to GHCR"
make -f Makefile_Helm_Packaging_Releasing helm-oci-registry-login

echo "Step 2: Push chart package to GHCR"
make -f Makefile_Helm_Packaging_Releasing helm-push-chart-packag-to-registry

echo "Step 3: Pull chart by version from GHCR"
make -f Makefile_Helm_Packaging_Releasing helm-pull-chart-by-version-from-registry

echo "Step 4: Add a demo Helm repo"
make -f Makefile_Helm_Packaging_Releasing helm-add-a-repo

echo "Step 5: Update repo cache"
make -f Makefile_Helm_Packaging_Releasing helm-repo-update

echo "Step 6: Search chart repo"
make -f Makefile_Helm_Packaging_Releasing helm-search-repo

echo "[03] Completed. Check downloads/ for pulled charts and command output for repo operations."
echo " ==========================================================================================="
echo " ==========================================================================================="