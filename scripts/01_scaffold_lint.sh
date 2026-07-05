#!/usr/bin/env bash
set -euo pipefail
#!/bin/bash

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
# Exercise 01: Scaffold and Lint
# Script: 01_scaffold_lint.sh
# Purpose:
#   - Ensure the chart skeleton exists (without overwriting custom files).
#   - Run helm lint to validate chart structure and values usage.
#   - Render dev manifests to verify that dev.yaml + values.yaml work together.
# How to check output:
#   - Lint: Scroll for errors/warnings in the helm lint output.
#   - Template: Inspect the rendered YAML (Deployment, Service, etc.) in the terminal.
echo -e "${YELLOW}[01] Scaffold and lint chart"
make -f Makefile_Helm_Packaging_Releasing print_scaffold_lint_render_purpose
pause
echo -e "${GREEN} Step 1: Ensure chart skeleton exists (helm-scaffold-new-chart) ${RESET}"
pause
make -f Makefile_Helm_Packaging_Releasing helm-scaffold-new-chart

echo -e "${GREEN} Step 2: Lint chart (helm-lint-validate-chart) ${RESET}"
pause
make -f Makefile_Helm_Packaging_Releasing helm-lint-validate-chart

echo -e "${GREEN} Step 3: Render dev manifests (helm-template-dev) ${RESET}"
pause
make -f Makefile_Helm_Packaging_Releasing helm-template-dev

echo -e "${YELLOW}[01] Completed. Check lint output for errors and template output for expected resources."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause