# Architecture Decision Records — TNI-MM-Mods

---

## ADR-001: Ветки `beta` / `main`

| Поле | Значение |
|------|----------|
| **Статус** | Принято |
| **Дата** | 2026-07-30 |

### Решение

- **`beta`** — рабочая ветка разработки.
- **`main`** — стабильная линия и **default** на GitHub.
- Sync-toolkit workflow открывает PR в **`main`**.
- **Релизы модов** (`release-*.yml`) — только с **`main`** (push или `workflow_dispatch` с `--target main`). Поток: разработка на `beta` → merge в `main` → CI → MM+ Обновить.

### Почему

Так же устроены соседние репозитории (`TNI-ModManager-Plus`, `TNI-data-extractor`). Релиз только из `main` отделяет черновики на `beta` от опубликованных версий в каталоге MM+.

---

## ADR-002: Scope = библиотека модов + toolkit-снимок

| Поле | Значение |
|------|----------|
| **Статус** | Принято |
| **Дата** | 2026-07-30 |

### Решение

В репозитории:

- `mods/` — моды этой библиотеки (публикуются);
- `toolkit/` — отфильтрованный снимок **community** [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods) (без `docs/` сайта, без Mod Manager, без upstream `.github/`); это **не** официальный kit — см. ADR-005;
- `toolkit/mods/` — примеры из того же источника, **не** релизятся.

**Не** держать: Hugo-сайт, оригинальный Mod Manager, CI релизов чужих модов.

### Почему

Нужна совместимость с API/форматом оригинала без дублирования продуктов (сайт, менеджер), которые живут в других репо.

---

## ADR-003: Автосинхронизация toolkit через PR

| Поле | Значение |
|------|----------|
| **Статус** | Принято |
| **Дата** | 2026-07-30 |

### Решение

GitHub Action ежедневно (и вручную) синхронизирует `toolkit/` из community-репо `CJFWeatherhead/TNI-Mods` и при изменениях открывает **PR в `main`** (не прямой push). Корневые `mods/` не затрагиваются. Официальный kit — другой репозиторий; смена источника sync не входит в этот ADR (см. ADR-005).

Скрипт: [`scripts/sync-toolkit.sh`](../scripts/sync-toolkit.sh).

### Почему

Безопасный просмотр upstream-диффа перед мержем; свои моды не затираются.

---

## ADR-004: Каталог через GitHub Releases + Mod Manager Plus

| Поле | Значение |
|------|----------|
| **Статус** | Принято |
| **Дата** | 2026-07-30 |

### Решение

Моды обнаруживаются [TNI-ModManager-Plus](https://github.com/DefaultUsernameWasAleadyTaken/TNI-ModManager-Plus) по:

1. записи репо в `mod-sources.json` менеджера;
2. GitHub Release с тегом **`modId-vX.Y.Z`**;
3. zip-ассету (папка `modId/` внутри zip).

### Почему

Тот же контракт, что у community TNI-Mods и других сторонних репо в каталоге менеджера.

---

## ADR-005: Официальный kit vs community TNI-Mods

| Поле | Значение |
|------|----------|
| **Статус** | Зафиксировано (смена sync — отложена) |
| **Дата** | 2026-08-02 |
| **Источник** | Discord: Pocosia Studios → @gunslinger755, 2026-07-31 |

### Решение

1. **[treefarmer741/Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit)** — **официальный** моддинг-kit игры (Godot Sandbox / libriscv). Студия явно указала его как ориентир для разработки модов.
2. **[CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods)** — **не** официальный репозиторий; вклад игроков. Там же community-коллекция модов / менеджер.
3. Текущий sync `toolkit/` **остаётся** на community TNI-Mods, пока нет отдельного решения о переносе на официальный kit.
4. В документации **не** называть TNI-Mods «официальным».

### Почему

Ответ студии снимает путаницу со старой формулировкой «официальный кит». Стратегию sync менять рано: формат Lua-модов совместим, а перенос источника — отдельная работа.

### Открыто

- Переключать ли `scripts/sync-toolkit.sh` / workflow на официальный kit.
- Откуда рекомендовать игрокам брать `luajit-support` (kit continuous vs TNI-Mods).

---

## Связанные документы

- [`architecture.md`](architecture.md) · [`mod-lifecycle.md`](mod-lifecycle.md) · [`releasing.md`](releasing.md) · [`AGENTS.md`](../AGENTS.md)
