# Architecture — TNI-MM-Mods

**Ветки:** `beta` (разработка) · `main` (стабильная) · **Связано:** [decisions.md](decisions.md) · [releasing.md](releasing.md)

---

## Русский

Сторонняя **библиотека модов** для Tower Networking Inc. Совместима с форматом Lua-модов сообщества и официального kit, но **не** является форком целиком: без сайта и без оригинального Mod Manager.

### Источники моддинга ([ADR-005](decisions.md))

| Репозиторий | Статус | Роль для нас |
|-------------|--------|--------------|
| [treefarmer741/Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit) | **Официальный kit** (подтверждено Pocosia Studios, 2026-07-31) | Канон API / Godot Sandbox; sync сюда — **пока не** переключали |
| [CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) | Community (вклад игроков, **не** официальный) | Текущий источник `toolkit/` |
| [libriscv/godot-sandbox](https://github.com/libriscv/godot-sandbox) | Стек игры | Sandbox моддинга |

| Область | Путь | Роль |
|---------|------|------|
| Наши моды | `mods/<mod-id>/` | исходники + релизы GitHub |
| Тулкит | `toolkit/` | снимок **community** TNI-Mods (API, typing, примеры) |
| Примеры | `toolkit/mods/` | только справочник, **не** релизятся |
| Sync | `scripts/sync-toolkit.sh` | ручная синхронизация toolkit |
| CI sync | `.github/workflows/sync-toolkit.yml` | ежедневно → PR в `main` |
| CI мод | `.github/workflows/release-<mod>.yml` | релиз мода с `main` (`modId-vX.Y.Z`) |
| IDE Lua | `.luarc.json` → `toolkit/lua-typing` | автодополнение |
| Docs | `docs/`, `AGENTS.md` | архитектура, ADR, релизы |

```text
офиц. kit (treefarmer741)     — канон, sync TBD
community TNI-Mods  --(filter)-->  toolkit/   ← сейчас
                                      ^
                                      | sync Action / script
наша библиотека  mods/  --(release zip)-->  GitHub Releases
                                              |
                                    TNI-ModManager-Plus (mod-sources.json)
```

### Совместимость с игрой

- Lua-моды требуют `luajit-support` (релизы официального kit или community TNI-Mods).
- Пути userdata: Windows `…\Mods\`; Linux `…/mods/`.
- Файлы мода: `entry.lua`, `mod.jsonc`, `metadata.yaml` (+ опционально icon, ui-config).

### Связанные документы

- [decisions.md](decisions.md) · [mod-lifecycle.md](mod-lifecycle.md) · [releasing.md](releasing.md) · [README.md](../README.md) · [AGENTS.md](../AGENTS.md)

---

## English

Third-party mod library. Official kit is treefarmer741/Tower-Networking-Inc-modding-kit; CJFWeatherhead/TNI-Mods is community (current `toolkit/` sync source). Own mods in `mods/`; releases use `modId-vX.Y.Z` for Mod Manager Plus. See ADR-005.
