#!/usr/bin/env bash
set -euo pipefail

# Exercise 06: Diff and Rollback
# Script: 06_diff_and_rollback.sh
# Purpose:
#   - Show diff for dev release before applying changes.
#   - Apply a new dev release revision.
#   - Roll back to a previous revision.
# How to check output:
#   - Inspect helm diff output for resource changes.
#   - Check helm history before and after rollback.
echo "[06] Diff and rollback"

echo "Step 1: Diff dev release changes before upgrade"
make -f Makefile_Helm_Packaging_Releasing helm-diff-dev-release-change-before-apply-in-namespace

echo "Step 2: Upgrade dev release"
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace

echo "Step 3: Show dev release history after upgrade"
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo "Step 4: Roll back dev release to previous revision"
make -f Makefile_Helm_Packaging_Releasing helm-rollback-dev-release-to-previous-version-in-namespace

echo "Step 5: Show dev release history after rollback"
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo "[06] Completed. Compare history output before and after rollback."
echo " ==========================================================================================="
echo " ==========================================================================================="