#!/usr/bin/env bash
set -euo pipefail

# Exercise 04: Dependency Management
# Script: 04_dependencies.sh
# Purpose:
#   - Update chart dependencies (Chart.yaml → Chart.lock).
#   - Build dependencies into charts/ subdirectory.
#   - Render dev manifests with dependencies included.
# How to check output:
#   - Confirm Chart.lock exists and is updated.
#   - Check charts/catalog-service/charts/ for dependency archives.
#   - Inspect template output to see dependency resources if applicable.

echo "[04] Dependency management"

echo "Step 1: Update dependencies (helm-dependency-update-in-lockfile)"
make -f Makefile_Helm_Packaging_Releasing helm-dependency-update-in-lockfile

echo "Step 2: Build dependencies from lockfile (helm-dependency-build-from-loackfile)"
make -f Makefile_Helm_Packaging_Releasing helm-dependency-build-from-loackfile

echo "Step 3: Render dev manifests with dependencies (helm-template-dev)"
make -f Makefile_Helm_Packaging_Releasing helm-template-dev

echo "[04] Completed. Check Chart.lock and charts/ subdirectory for dependencies."