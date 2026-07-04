#!/usr/bin/env bash
set -euo pipefail

# Exercise 02: Package and Publish
# Script: 02_package_publish.sh
# Purpose:
#   - Package the chart into a versioned .tgz file.
#   - Login to GHCR (OCI registry).
#   - Push the packaged chart to GHCR.
# How to check output:
#   - Verify dist/catalog-service-<version>.tgz exists.
#   - Check GHCR UI (Packages) to confirm the chart appears under helm-lab.
echo "[02] Package and publish chart"

echo "Step 1: Package chart (helm-package-chart-with-version)"
make -f Makefile_Helm_Packaging_Releasing helm-package-chart-with-version

echo "Step 2: Login to GHCR (helm-oci-registry-login)"
make -f Makefile_Helm_Packaging_Releasing helm-oci-registry-login

echo "Step 3: Push packaged chart to GHCR (helm-push-chart-packag-to-registry)"
make -f Makefile_Helm_Packaging_Releasing helm-push-chart-packag-to-registry

echo "[02] Completed. Check dist/ for the .tgz file and GHCR for the published chart."
echo " ==========================================================================================="
echo " ==========================================================================================="