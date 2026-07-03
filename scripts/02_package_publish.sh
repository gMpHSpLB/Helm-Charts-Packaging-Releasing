#!/usr/bin/env bash
set -euo pipefail

make package
make show-chart
make show-values
make registry-login
make push