#!/usr/bin/env bash
set -euo pipefail

make registry-login
make push
make pull
make repo-add
make repo-update
make search-repo
make show-chart
make show-values