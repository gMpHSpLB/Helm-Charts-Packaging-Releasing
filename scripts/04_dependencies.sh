#!/usr/bin/env bash
set -euo pipefail

make dependency-update
make dependency-build
make template-dev