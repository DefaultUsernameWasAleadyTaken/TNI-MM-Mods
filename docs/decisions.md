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
- Sync toolkit/examples workflow открывает PR в **`main`**.
- **Релизы модов** (`release-*.yml`) — только с **`main`** (push или `workflow_dispatch` с `--target main`). Поток: разработка на `beta` → merge в `main` → CI → MM+ Обновить.

### Почему

Так же устроены соседние репозитории (`TNI-ModManager-Plus`, `TNI-data-extractor`). Релиз только из `main` отделяет черновики на `beta` от опубликованных версий в каталоге MM+.

---

## ADR-002: Scope = библиотека модов + toolkit + examples

| Поле | Значение |
|------|----------|
| **Статус** | Принято (обновлено 2026-08-02) |
| **Дата** | 2026-07-30 |

### Решение

В репозитории:

- `mods/` — моды этой библиотеки (публикуются);
- `toolkit/` — отфильтрованный снимок **официального** [Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit) (без `.github/`, без лишнего; см. ADR-005);
- `toolkit/mods/` — примеры из официального kit, **не** релизятся;
- `examples/` — снимок `mods/` из community [TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods), **не** релизятся.

**Не** держать: Hugo-сайт, оригинальный Mod Manager, CI релизов чужих модов.

### Почему

Актуальный API/typing из канона студии + богатые community-примеры без смешивания двух `--delete` sync в одну папку.

---

## ADR-003: Автосинхронизация toolkit и examples через PR

| Поле | Значение |
|------|----------|
| **Статус** | Принято (обновлено 2026-08-02) |
| **Дата** | 2026-07-30 |

### Решение

GitHub Action ежедневно (и вручную) запускает [`scripts/sync-all.sh`](../scripts/sync-all.sh):

1. `toolkit/` ← официальный kit (`sync-toolkit.sh`);
2. `examples/` ← community TNI-Mods `mods/` (`sync-examples.sh`);

при изменениях открывает **PR в `main`** (не прямой push). Корневые `mods/` не затрагиваются.

Скрипты: [`sync-toolkit.sh`](../scripts/sync-toolkit.sh), [`sync-examples.sh`](../scripts/sync-examples.sh), [`sync-all.sh`](../scripts/sync-all.sh).  
Workflow: [`.github/workflows/sync-toolkit.yml`](../.github/workflows/sync-toolkit.yml).

### Почему

Безопасный просмотр диффа перед мержем; свои моды не затираются; два источника не конфликтуют.

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
| **Статус** | Принято (sync разделён) |
| **Дата** | 2026-08-02 |
| **Источник** | Discord: Pocosia Studios → @gunslinger755, 2026-07-31 |

### Решение

1. **[treefarmer741/Tower-Networking-Inc-modding-kit](https://github.com/treefarmer741/Tower-Networking-Inc-modding-kit)** — **официальный** моддинг-kit (Godot Sandbox / libriscv). Источник **`toolkit/`**.
2. **[CJFWeatherhead/TNI-Mods](https://github.com/CJFWeatherhead/TNI-Mods)** — **не** официальный; вклад игроков. Источник **`examples/`** (только `mods/`).
3. В документации **не** называть TNI-Mods «официальным».
4. `luajit-support` для игроков: предпочтительно continuous-релизы официального kit; community-релизы допустимы как запасной вариант.

### Почему

Ответ студии задаёт канон API; community-примеры полезны для обучения и паттернов. Разделение папок устраняет конфликт двух sync с `--delete`.

---

## Связанные документы

- [`architecture.md`](architecture.md) · [`mod-lifecycle.md`](mod-lifecycle.md) · [`releasing.md`](releasing.md) · [`AGENTS.md`](../AGENTS.md)
