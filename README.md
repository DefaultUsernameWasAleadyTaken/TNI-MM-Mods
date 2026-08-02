# TNI-MM-Mods

Сторонняя библиотека модов для [Tower Networking Inc](https://store.steampowered.com/app/2939600/Tower_Networking_Inc/).

**Источники моддинга ([ADR-005](docs/decisions.md)):**
- **Официальный kit** → `toolkit/`: [treefarmer741/Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit) (Godot Sandbox / [libriscv](https://github.com/libriscv/godot-sandbox)).
- **Community** → `examples/`: [CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) (**не** официальный; sync только `mods/`).

Репозиторий: https://github.com/DefaultUsernameWasAleadyTaken/TNI-MM-Mods  
Основная ветка: **`main`** · разработка: **`beta`** · релизы модов: только из **`main`** (`beta` → merge → CI)

Документация: [`docs/`](docs/) · [`AGENTS.md`](AGENTS.md) · правила Cursor: [`.cursor/rules/`](.cursor/rules/)

## Структура

```
TNI-MM-Mods/
├── mods/                 # публикуемые моды
├── examples/             # community-примеры (не релизятся)
├── templates/            # заготовки (не релизятся, не в MM+)
│   ├── mod/              # файлы мода
│   └── release-mod.yml.example
├── scripts/
│   ├── sync-toolkit.sh   # официальный kit → toolkit/
│   ├── sync-examples.sh  # community mods/ → examples/
│   ├── sync-all.sh       # оба sync
│   └── sync-lib.sh       # rsync / cp fallback
├── .github/workflows/
│   └── sync-toolkit.yml  # ежедневный sync + PR
└── toolkit/              # снимок официального kit
    ├── mods/             # примеры kit (не релизятся)
    ├── lua-typing/       # типы Lua для IDE
    ├── include/          # C++ заголовки API игры
    ├── programs/         # шаблоны нативных модов + luajit-support
    ├── cmake/            # Zig toolchain (riscv64)
    └── .upstream-sha     # SHA официального kit
```

Совместимость: форматы `entry.lua`, `mod.jsonc`, `metadata.yaml`. Для Lua-модов нужен `luajit-support` — предпочтительно из [релизов официального kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit/releases).

## Автосинхронизация

Раз в сутки (и вручную через Actions → **Sync toolkit and examples**) workflow:

1. `toolkit/` ← официальный kit (`treefarmer741/…`)
2. `examples/` ← `mods/` community TNI-Mods
3. При изменениях — PR в `main` (`chore/sync-sources`)

Корневые `mods/` workflow **не трогает**.

Локально:

```bash
bash scripts/sync-all.sh
# или по отдельности:
bash scripts/sync-toolkit.sh
bash scripts/sync-examples.sh
```

Подробности по API и сборке — в [`toolkit/README.md`](toolkit/README.md) после sync.

Архитектура и ADR: [`docs/architecture.md`](docs/architecture.md), [`docs/decisions.md`](docs/decisions.md).  
Жизненный цикл мода (создать / обновить / удалить): [`docs/mod-lifecycle.md`](docs/mod-lifecycle.md).  
Как релизить моды для менеджера: [`docs/releasing.md`](docs/releasing.md).
