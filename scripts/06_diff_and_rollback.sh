#!/usr/bin/env bash
set -euo pipefail

make diff-dev
make upgrade-install-dev
make history-dev
make rollback-dev
make history-dev