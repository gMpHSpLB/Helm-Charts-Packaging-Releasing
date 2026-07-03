#!/usr/bin/env bash
set -euo pipefail

make scaffold
make lint
make template-dev