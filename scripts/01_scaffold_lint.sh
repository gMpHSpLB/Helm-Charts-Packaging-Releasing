#!/usr/bin/env bash
set -euo pipefail

# Exercise 01: Scaffold and Lint
# Script: 01_scaffold_lint.sh
# Purpose:
#   - Ensure the chart skeleton exists (without overwriting custom files).
#   - Run helm lint to validate chart structure and values usage.
#   - Render dev manifests to verify that dev.yaml + values.yaml work together.
# How to check output:
#   - Lint: Scroll for errors/warnings in the helm lint output.
#   - Template: Inspect the rendered YAML (Deployment, Service, etc.) in the terminal.

echo "[01] Scaffold and lint chart"

echo "Step 1: Ensure chart skeleton exists (helm-scaffold-new-chart)"
make -f Makefile_Helm_Packaging_Releasing helm-scaffold-new-chart

echo "Step 2: Lint chart (helm-lint-validate-chart)"
make -f Makefile_Helm_Packaging_Releasing helm-lint-validate-chart

echo "Step 3: Render dev manifests (helm-template-dev)"
make -f Makefile_Helm_Packaging_Releasing helm-template-dev

echo "[01] Completed. Check lint output for errors and template output for expected resources."