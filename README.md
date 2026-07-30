# TNI-MM-Mods

Сторонняя библиотека модов для [Tower Networking Inc](https://store.steampowered.com/app/2939600/Tower_Networking_Inc/), совместимая с официальным моддинг-китом [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods).

Репозиторий: https://github.com/DefaultUsernameWasAleadyTaken/TNI-MM-Mods  
Основная ветка: **`main`** · разработка: **`beta`** · релизы модов: только из **`main`** (`beta` → merge → CI)

Документация: [`docs/`](docs/) · [`AGENTS.md`](AGENTS.md) · правила Cursor: [`.cursor/rules/`](.cursor/rules/)

## Структура

```
TNI-MM-Mods/
├── mods/                 # публикуемые моды
├── templates/            # заготовки (не релизятся, не в MM+)
│   ├── mod/              # файлы мода
│   └── release-mod.yml.example
├── scripts/
│   └── sync-toolkit.sh   # ручная синхронизация toolkit/
├── .github/workflows/
│   └── sync-toolkit.yml  # ежедневный sync + PR
└── toolkit/              # снимок upstream (без сайта и менеджера модов)
    ├── mods/             # примеры из оригинала (не релизятся)
    ├── lua-typing/       # типы Lua для IDE
    ├── include/          # C++ заголовки API игры
    ├── programs/         # шаблоны нативных модов + luajit-support
    ├── cmake/            # Zig toolchain (riscv64)
    └── .upstream-sha     # последний синхронизированный коммит upstream
```

Совместимость: те же форматы `entry.lua`, `mod.jsonc`, `metadata.yaml`. Для Lua-модов нужен `luajit-support` из [релизов TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods/releases).

## Автосинхронизация toolkit

Раз в сутки (и вручную через Actions → **Sync toolkit from upstream**) workflow:

1. Берёт `main` из `CJFWeatherhead/TNI-Mods`
2. Копирует содержимое в `toolkit/` (без `docs/`, Mod Manager, `.github/`)
3. Если есть изменения — открывает PR в ветку `main` (`chore/sync-toolkit`)

Корневые `mods/` workflow **не трогает**.

Локально:

```bash
bash scripts/sync-toolkit.sh
```

Подробности по API и сборке — в [`toolkit/README.md`](toolkit/README.md) после sync.

Архитектура и ADR: [`docs/architecture.md`](docs/architecture.md), [`docs/decisions.md`](docs/decisions.md).  
Жизненный цикл мода (создать / обновить / удалить): [`docs/mod-lifecycle.md`](docs/mod-lifecycle.md).  
Как релизить моды для менеджера: [`docs/releasing.md`](docs/releasing.md).
