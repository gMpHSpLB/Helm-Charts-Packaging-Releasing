#!/usr/bin/env bash
set -euo pipefail

# Script: run_all_scripts.sh
# Purpose:
#   - Run the entire Helm lab end-to-end:
#     scaffold/lint, package/publish, registry operations,
#     dependencies, release management, diff/rollback,
#     env inspection, and GHCR OCI roundtrip.
# How to check output:
#   - Follow logs section by section.
#   - Use kubectl and helm commands to inspect cluster state between runs.

echo "[ALL] Running Helm portfolio lab end-to-end..."

# Optional: ensure Minikube is up before running Helm exercises
make -f Makefile_Setup ensure-minikube
make -f Makefile_Setup enable-minikube-addons

./scripts/01_scaffold_lint.sh
./scripts/02_package_publish.sh
./scripts/03_registry_roundtrip.sh
./scripts/04_dependencies.sh
./scripts/05_release_dev.sh
./scripts/06_diff_and_rollback.sh
./scripts/07_env_inspection.sh
./scripts/08_ghcr_roundtrip.sh

echo "[ALL] All Helm lab exercises completed."
echo "Use 'kubectl get all -n catalog-dev' and similar commands to explore the resulting cluster state."
