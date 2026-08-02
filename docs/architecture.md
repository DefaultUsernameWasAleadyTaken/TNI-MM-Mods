# Architecture — TNI-MM-Mods

**Ветки:** `beta` (разработка) · `main` (стабильная) · **Связано:** [decisions.md](decisions.md) · [releasing.md](releasing.md)

---

## Русский

Сторонняя **библиотека модов** для Tower Networking Inc. Совместима с форматом Lua-модов официального kit и community-примеров; **не** форк целиком: без сайта и без оригинального Mod Manager.

### Источники моддинга ([ADR-005](decisions.md))

| Репозиторий | Статус | Роль для нас |
|-------------|--------|--------------|
| [treefarmer741/Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit) | **Официальный kit** (Pocosia Studios) | Источник `toolkit/` (API, typing, programs) |
| [CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) | Community (**не** официальный) | Источник `examples/` (`mods/` upstream) |
| [libriscv/godot-sandbox](https://github.com/libriscv/godot-sandbox) | Стек игры | Sandbox моддинга |

| Область | Путь | Роль |
|---------|------|------|
| Наши моды | `mods/<mod-id>/` | исходники + релизы GitHub |
| Тулкит | `toolkit/` | снимок **официального** kit |
| Примеры kit | `toolkit/mods/` | официальные примеры, **не** релизятся |
| Community-примеры | `examples/` | снимок community `mods/`, **не** релизятся |
| Sync toolkit | `scripts/sync-toolkit.sh` | из официального kit |
| Sync examples | `scripts/sync-examples.sh` | из community TNI-Mods |
| Sync оба | `scripts/sync-all.sh` | toolkit + examples |
| CI sync | `.github/workflows/sync-toolkit.yml` | ежедневно → PR в `main` |
| CI мод | `.github/workflows/release-<mod>.yml` | релиз мода с `main` (`modId-vX.Y.Z`) |
| IDE Lua | `.luarc.json` → `toolkit/lua-typing` | автодополнение |
| Docs | `docs/`, `AGENTS.md` | архитектура, ADR, релизы |

```text
офиц. kit (treefarmer741)  --(filter)-->  toolkit/
community TNI-Mods/mods/   --(sync)---->  examples/
                                              ^
                                              | sync-all / CI
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

Third-party mod library. `toolkit/` syncs from the official treefarmer741 kit; `examples/` syncs community mods from CJFWeatherhead/TNI-Mods. Own mods in `mods/`; releases use `modId-vX.Y.Z` for Mod Manager Plus. See ADR-005.
