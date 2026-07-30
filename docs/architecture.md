# Architecture — TNI-MM-Mods

**Ветки:** `beta` (разработка) · `main` (стабильная) · **Связано:** [decisions.md](decisions.md) · [releasing.md](releasing.md)

---

## Русский

Сторонняя **библиотека модов** для Tower Networking Inc. Совместима с форматом официального кита [CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods), но **не** является форком всего upstream: без сайта и без оригинального Mod Manager.

| Область | Путь | Роль |
|---------|------|------|
| Наши моды | `mods/<mod-id>/` | исходники + релизы GitHub |
| Тулкит | `toolkit/` | снимок upstream (API, typing, примеры) |
| Примеры | `toolkit/mods/` | только справочник, **не** релизятся |
| Sync | `scripts/sync-toolkit.sh` | ручная синхронизация toolkit |
| CI sync | `.github/workflows/sync-toolkit.yml` | ежедневно → PR в `main` |
| CI мод | `.github/workflows/release-<mod>.yml` | релиз мода с `main` (`modId-vX.Y.Z`) |
| IDE Lua | `.luarc.json` → `toolkit/lua-typing` | автодополнение |
| Docs | `docs/`, `AGENTS.md` | архитектура, ADR, релизы |

```text
upstream TNI-Mods  --(filter)-->  toolkit/
                                      ^
                                      | sync Action / script
наша библиотека  mods/  --(release zip)-->  GitHub Releases
                                              |
                                    TNI-ModManager-Plus (mod-sources.json)
```

### Совместимость с игрой

- Lua-моды требуют `luajit-support` из релизов upstream.
- Пути userdata: Windows `…\Mods\`; Linux `…/mods/`.
- Файлы мода: `entry.lua`, `mod.jsonc`, `metadata.yaml` (+ опционально icon, ui-config).

### Связанные документы

- [decisions.md](decisions.md) · [mod-lifecycle.md](mod-lifecycle.md) · [releasing.md](releasing.md) · [README.md](../README.md) · [AGENTS.md](../AGENTS.md)

---

## English

Third-party mod library compatible with official TNI-Mods formats. Own mods live in `mods/`; `toolkit/` is a filtered upstream snapshot synced by Action/script. Releases use `modId-vX.Y.Z` tags for Mod Manager Plus discovery.
