#!/usr/bin/env bash
set -euo pipefail

# Exercise 05: Release Management
# Script: 05_release_dev.sh
# Purpose:
#   - Install or upgrade dev, staging, and prod releases.
#   - Inspect dev release history, manifest, and values.
# How to check output:
#   - Use kubectl to list deployments in dev/staging/prod namespaces.
#   - Examine helm history, helm get manifest, and helm get values output.
echo "[05] Release management (dev/staging/prod)"

echo "Step 1: Install/upgrade dev release"
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace

echo "Step 2: Install/upgrade staging release"
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-staging-release-in-namespace

echo "Step 3: Install/upgrade prod release"
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-prod-release-in-namespace

echo "Step 4: Show dev release history"
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo "Step 5: Get dev release manifest"
make -f Makefile_Helm_Packaging_Releasing helm-get-manifest-dev-release-in-namespace

echo "Step 6: Get dev release values"
make -f Makefile_Helm_Packaging_Releasing helm-get-values-dev-release-in-namespace

echo "[05] Completed. Use 'kubectl get deploy -n catalog-dev' etc. to verify releases."
echo " ==========================================================================================="
echo " ==========================================================================================="
