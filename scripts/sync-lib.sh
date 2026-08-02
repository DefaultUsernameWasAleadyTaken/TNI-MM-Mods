#!/usr/bin/env bash
# Общие хелперы для sync-*.sh (rsync или fallback без rsync).
# shellcheck shell=bash

sync_mirror() {
  local src="$1"
  local dest="$2"
  shift 2

  if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete "$@" "$src" "$dest"
    return
  fi

  echo "==> rsync not found; using cp fallback (delete + copy)"
  # Разбор простых --exclude='name' / --exclude=name
  local -a excludes=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --exclude=*)
        excludes+=("${1#--exclude=}")
        shift
        ;;
      --exclude)
        excludes+=("$2")
        shift 2
        ;;
      *)
        echo "ERROR: unsupported sync_mirror arg without rsync: $1" >&2
        exit 1
        ;;
    esac
  done

  # Нормализуем trailing slash
  src="${src%/}/"
  dest="${dest%/}"

  mkdir -p "$dest"
  # Удаляем всё в dest, кроме того что потом скопируем заново
  find "$dest" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  local item base skip
  shopt -s dotglob nullglob
  for item in "$src"*; do
    base="$(basename "$item")"
    skip=0
    for ex in "${excludes[@]}"; do
      # exclude вида '.git/' → сравниваем с именем
      ex="${ex%/}"
      if [[ "$base" == "$ex" ]]; then
        skip=1
        break
      fi
    done
    if [[ $skip -eq 1 ]]; then
      continue
    fi
    cp -a "$item" "$dest/"
  done
  shopt -u dotglob nullglob
}
