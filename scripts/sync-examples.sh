#!/usr/bin/env bash
# Синхронизирует examples/ из mods/ community-репо CJFWeatherhead/TNI-Mods.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=sync-lib.sh
source "$ROOT/scripts/sync-lib.sh"

UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/CJFWeatherhead/TNI-Mods.git}"
UPSTREAM_REF="${UPSTREAM_REF:-main}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Cloning ${UPSTREAM_REPO}@${UPSTREAM_REF}"
git clone --depth 1 --branch "$UPSTREAM_REF" "$UPSTREAM_REPO" "$TMP/upstream"

if [[ ! -d "$TMP/upstream/mods" ]]; then
  echo "ERROR: upstream has no mods/ directory" >&2
  exit 1
fi

echo "==> Syncing upstream mods/ into examples/"
mkdir -p "$ROOT/examples"
sync_mirror "$TMP/upstream/mods/" "$ROOT/examples/" --exclude='.git/'

cat > "$ROOT/examples/README.md" <<'EOF'
# Community example mods

Примеры из community [CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) (`mods/`).
Это **не** официальный kit — см. [ADR-005](../docs/decisions.md).

**Не релизятся** из этого репозитория — только справочник по структуре, API и приёмам.

Официальный toolkit (API, typing, kit-примеры) — [`../toolkit/`](../toolkit/).  
Свои моды — [`../mods/`](../mods/).
EOF

UPSTREAM_SHA="$(git -C "$TMP/upstream" rev-parse HEAD)"
echo "$UPSTREAM_SHA" > "$ROOT/examples/.upstream-sha"
echo "==> Synced community examples SHA: $UPSTREAM_SHA"
echo "==> Done"
