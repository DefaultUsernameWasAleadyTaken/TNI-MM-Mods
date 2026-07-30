# AGENTS — TNI-MM-Mods

## Русский

- **Репо:** https://github.com/DefaultUsernameWasAleadyTaken/TNI-MM-Mods
- **Ветки ([ADR-001](docs/decisions.md)):** `beta` — разработка; `main` — стабильная (default на GitHub).
- **Scope ([ADR-002](docs/decisions.md)):** `mods/` (наши моды), `toolkit/` (upstream-снимок), `scripts/`, `docs/`, `.cursor/`.
- **Язык с пользователем:** русский.
- **Авто-режим:** действовать без лишних «ок?».
- **Commit / push:** **не выполнять**, пока пользователь явно не попросит в чате **или** не подтвердит кнопкой в диалоге Cursor (правило `.cursor/rules/no-commit-push.mdc`).
- **Формат мода:** как у TNI-Mods — `entry.lua`, `mod.jsonc`, `metadata.yaml`, `README.md`.
- **Релизы модов:** только из **`main`** (разработка на `beta` → merge → CI). Тег `modId-vX.Y.Z` + zip; см. [`docs/releasing.md`](docs/releasing.md). Жизненный цикл: [`docs/mod-lifecycle.md`](docs/mod-lifecycle.md).
- **Toolkit:** синхронизация из upstream — [`docs/architecture.md`](docs/architecture.md); не править `toolkit/` вручную без нужды (лучше через sync).
- **Связанные проекты:** [TNI-ModManager-Plus](https://github.com/DefaultUsernameWasAleadyTaken/TNI-ModManager-Plus) (каталог через `mod-sources.json`), upstream [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods).
- Правила Cursor: `.cursor/rules/`.

## English

- Branches: `beta` = development, `main` = stable. Own mods in `mods/`; `toolkit/` is filtered upstream snapshot. Mod releases only from `main` (`beta` → merge → CI): `modId-vX.Y.Z` + zip. User language: Russian. Never `git commit` / `git push` unless the user explicitly asks in chat or confirms via a Cursor dialog button.
