#!/usr/bin/env bash
set -euo pipefail

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

echo "[07] Environment and troubleshooting"

echo "Step 1: Show Helm environment variables"
make -f Makefile_Helm_Packaging_Releasing helm-show-env-variables

echo "Step 2: List dev releases"
make -f Makefile_Helm_Packaging_Releasing helm-list-dev-releases-in-namespace

echo "Step 3: Show dev release status"
make -f Makefile_Helm_Packaging_Releasing helm-show-status-dev-release-in-namespace

echo "Step 4: Run Helm tests for dev release (with logs)"
make -f Makefile_Helm_Packaging_Releasing helm-run-tests-for-dev-release-in-namespace

echo "[07] Completed. Inspect status and test logs for any issues."