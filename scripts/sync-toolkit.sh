#!/usr/bin/env bash
# Синхронизирует toolkit/ из официального Tower-Networking-Inc-modding-kit
# (без сайта, менеджера модов и CI).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=sync-lib.sh
source "$ROOT/scripts/sync-lib.sh"

UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit.git}"
UPSTREAM_REF="${UPSTREAM_REF:-main}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> Cloning ${UPSTREAM_REPO}@${UPSTREAM_REF}"
git clone --depth 1 --branch "$UPSTREAM_REF" "$UPSTREAM_REPO" "$TMP/upstream"

# Submodule LuaJIT (нужен для сборки нативных модов)
if ! git -C "$TMP/upstream" submodule update --init --depth 1 ext/LuaJIT; then
  echo "==> submodule LuaJIT failed; fetching pinned commit directly"
  LJ_SHA="$(git -C "$TMP/upstream" ls-tree HEAD ext/LuaJIT | awk '{print $3}')"
  if [[ -n "$LJ_SHA" ]]; then
    rm -rf "$TMP/upstream/ext/LuaJIT"
    mkdir -p "$TMP/upstream/ext"
    git clone --filter=blob:none --no-checkout https://github.com/LuaJIT/LuaJIT.git "$TMP/lj"
    git -C "$TMP/lj" fetch --depth 1 origin "$LJ_SHA"
    git -C "$TMP/lj" checkout "$LJ_SHA"
    cp -a "$TMP/lj/." "$TMP/upstream/ext/LuaJIT/"
    rm -rf "$TMP/lj" "$TMP/upstream/ext/LuaJIT/.git"
  else
    echo "WARN: could not resolve ext/LuaJIT SHA" >&2
  fi
fi

echo "==> Syncing into toolkit/"
mkdir -p "$ROOT/toolkit"
sync_mirror "$TMP/upstream/" "$ROOT/toolkit/" \
  --exclude='.git/' \
  --exclude='.github/' \
  --exclude='docs/' \
  --exclude='ModManager.bat' \
  --exclude='ModManagerGUI.ps1' \
  --exclude='ModManager-README.md' \
  --exclude='.luarc.json' \
  --exclude='.gitignore' \
  --exclude='.gitmodules'

# Исходники LuaJIT как обычные файлы (без вложенного .git submodule)
rm -rf "$ROOT/toolkit/ext/LuaJIT/.git"

# Краткая заметка поверх upstream README в mods/ (если каталог есть)
if [[ -d "$ROOT/toolkit/mods" ]]; then
  cat > "$ROOT/toolkit/mods/README.md" <<'EOF'
# Example mods (official kit)

Примеры из официального [Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit).
**Не релизятся** из этого репозитория.

Community-примеры — в [`../../examples/`](../../examples/).  
Свои моды — в [`../../mods/`](../../mods/).
EOF
fi

UPSTREAM_SHA="$(git -C "$TMP/upstream" rev-parse HEAD)"
echo "$UPSTREAM_SHA" > "$ROOT/toolkit/.upstream-sha"
echo "==> Synced official kit SHA: $UPSTREAM_SHA"
echo "==> Done"
