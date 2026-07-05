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
# Exercise 06: Diff and Rollback
# Script: 06_diff_and_rollback.sh
# Purpose:
#   - Show diff for dev release before applying changes.
#   - Apply a new dev release revision.
#   - Roll back to a previous revision.
# How to check output:
#   - Inspect helm diff output for resource changes.
#   - Check helm history before and after rollback.
echo -e "${YELLOW}[06] Diff and rollback"
make -f Makefile_Helm_Packaging_Releasing print_diff_and_rollback_purpose
pause
echo -e "${GREEN} Step 1: Diff dev release changes before upgrade"
pause
make -f Makefile_Helm_Packaging_Releasing helm-diff-dev-release-change-before-apply-in-namespace

echo -e "${GREEN} Step 2: Upgrade dev release"
pause
make -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace_1

echo -e "${GREEN} Step 3: Show dev release history after upgrade"
pause
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo -e "${GREEN} Step 3.1: Check Kubernetes state after upgrade (nodePort, replicas, env annotation)"
pause
make -f Makefile_Helm_Packaging_Releasing kubectl-check-dev-state-all

echo -e "${GREEN} Step 4: Roll back dev release to previous revision"
pause
make -f Makefile_Helm_Packaging_Releasing helm-rollback-dev-release-to-previous-version-in-namespace

echo -e "${GREEN} Step 5: Show dev release history after rollback"
pause
make -f Makefile_Helm_Packaging_Releasing helm-history-dev-release-in-namespace

echo -e "${GREEN} Step 5.1: Check Kubernetes state after rollback (nodePort, replicas, env annotation)"
pause
make -f Makefile_Helm_Packaging_Releasing kubectl-check-dev-state-all

echo -e "${GREEN} Step 6: Optional, deeper Helm inspection"
echo -e "${GREEN} Step 6.1: Get dev release manifest"
pause
make -f Makefile_Helm_Packaging_Releasing helm-get-manifest-dev-release-in-namespace

echo -e "${GREEN} Step 6.2: Get dev release values"
pause
make -f Makefile_Helm_Packaging_Releasing helm-get-values-dev-release-in-namespace

echo -e "${GREEN} Step 7: Optional cleanup – reset dev release to baseline"
pause
make -f Makefile_Helm_Packaging_Releasing helm-reset-dev-release-to-baseline

echo -e "${YELLOW}[06] Completed. Compare history output before and after rollback."
echo " ==========================================================================================="
echo " ==========================================================================================="
pause