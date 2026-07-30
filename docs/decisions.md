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
- `toolkit/` — отфильтрованный снимок upstream TNI-Mods (без `docs/` сайта, без Mod Manager, без upstream `.github/`);
- `toolkit/mods/` — примеры upstream, **не** релизятся.

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

GitHub Action ежедневно (и вручную) синхронизирует `toolkit/` из `CJFWeatherhead/TNI-Mods` и при изменениях открывает **PR в `main`** (не прямой push). Корневые `mods/` не затрагиваются.

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

Тот же контракт, что у upstream TNI-Mods и других сторонних репо в каталоге менеджера.

---

## Связанные документы

- [`architecture.md`](architecture.md) · [`mod-lifecycle.md`](mod-lifecycle.md) · [`releasing.md`](releasing.md) · [`AGENTS.md`](../AGENTS.md)
