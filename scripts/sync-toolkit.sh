#!/usr/bin/env bash
# Синхронизирует toolkit/ из upstream TNI-Mods (без сайта, менеджера модов и CI).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/CJFWeatherhead/TNI-Mods.git}"
UPSTREAM_REF="${UPSTREAM_REF:-main}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Cloning ${UPSTREAM_REPO}@${UPSTREAM_REF}"
git clone --depth 1 --branch "$UPSTREAM_REF" "$UPSTREAM_REPO" "$TMP/upstream"
git -C "$TMP/upstream" submodule update --init --depth 1 ext/LuaJIT || true

echo "==> Syncing into toolkit/"
mkdir -p "$ROOT/toolkit"
rsync -a --delete \
  --exclude='.git/' \
  --exclude='.github/' \
  --exclude='docs/' \
  --exclude='ModManager.bat' \
  --exclude='ModManagerGUI.ps1' \
  --exclude='ModManager-README.md' \
  --exclude='.luarc.json' \
  --exclude='.gitignore' \
  --exclude='.gitmodules' \
  "$TMP/upstream/" "$ROOT/toolkit/"

# Исходники LuaJIT как обычные файлы (без вложенного .git submodule)
rm -rf "$ROOT/toolkit/ext/LuaJIT/.git"

# Сохраняем заметку о назначении примеров (upstream README в mods/ более общий)
cat > "$ROOT/toolkit/mods/README.md" <<'EOF'
# Example mods (from upstream)

Примеры модов из официального [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods).
**Не релизятся** из этого репозитория — только справочник по структуре, API и приёмам.

Свои моды кладите в корневой [`../../mods/`](../../mods/).
EOF

UPSTREAM_SHA="$(git -C "$TMP/upstream" rev-parse HEAD)"
echo "$UPSTREAM_SHA" > "$ROOT/toolkit/.upstream-sha"
echo "==> Synced upstream SHA: $UPSTREAM_SHA"
echo "==> Done"
