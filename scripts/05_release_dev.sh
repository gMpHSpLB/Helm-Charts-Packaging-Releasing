#!/usr/bin/env bash
set -euo pipefail

make upgrade-install-dev
make history-dev
make get-manifest-dev
make get-values-dev
make status-dev
make test-dev