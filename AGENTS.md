# AGENTS — TNI-MM-Mods

## Русский

- **Репо:** https://github.com/DefaultUsernameWasAleadyTaken/TNI-MM-Mods
- **Ветки ([ADR-001](docs/decisions.md)):** `beta` — разработка; `main` — стабильная (default на GitHub).
- **Scope ([ADR-002](docs/decisions.md)):** `mods/` (наши моды), `toolkit/` (снимок community TNI-Mods), `scripts/`, `docs/`, `.cursor/`.
- **Источники ([ADR-005](docs/decisions.md)):** официальный kit — [Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit); [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) — community (**не** официальный). Sync `toolkit/` пока с community.
- **Язык с пользователем:** русский.
- **Авто-режим:** действовать без лишних «ок?».
- **Commit / push:** **не выполнять**, пока пользователь явно не попросит в чате **или** не подтвердит кнопкой в диалоге Cursor (правило `.cursor/rules/no-commit-push.mdc`).
- **Формат мода:** как у kit / TNI-Mods — `entry.lua`, `mod.jsonc`, `metadata.yaml`, `README.md`.
- **Релизы модов:** только из **`main`** (разработка на `beta` → merge → CI). Тег `modId-vX.Y.Z` + zip; см. [`docs/releasing.md`](docs/releasing.md). Жизненный цикл: [`docs/mod-lifecycle.md`](docs/mod-lifecycle.md).
- **Toolkit:** sync из community TNI-Mods — [`docs/architecture.md`](docs/architecture.md); не править `toolkit/` вручную без нужды (лучше через sync).
- **Связанные проекты:** [TNI-ModManager-Plus](https://github.com/DefaultUsernameWasAleadyTaken/TNI-ModManager-Plus), официальный [modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit), community [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods).
- Правила Cursor: `.cursor/rules/`.

## English

- Branches: `beta` = development, `main` = stable. Official kit = treefarmer741; CJFWeatherhead/TNI-Mods = community (current toolkit sync). Mod releases only from `main`: `modId-vX.Y.Z` + zip. User language: Russian. Never `git commit` / `git push` unless explicitly asked or confirmed via Cursor dialog.
