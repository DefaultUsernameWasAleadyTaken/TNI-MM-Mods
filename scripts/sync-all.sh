#!/usr/bin/env bash
# Синхронизирует toolkit/ (официальный kit) и examples/ (community).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash "$ROOT/scripts/sync-toolkit.sh"
bash "$ROOT/scripts/sync-examples.sh"

echo "==> sync-all complete"
