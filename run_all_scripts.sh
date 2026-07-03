#!/usr/bin/env bash
set -euo pipefail

./scripts/01_scaffold_lint.sh
./scripts/02_package_publish.sh
./scripts/03_registry_roundtrip.sh
./scripts/04_dependencies.sh
./scripts/05_release_dev.sh
./scripts/06_diff_and_rollback.sh
./scripts/07_env_inspection.sh