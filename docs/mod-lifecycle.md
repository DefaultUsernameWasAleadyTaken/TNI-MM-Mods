# Жизненный цикл мода — создать / обновить / удалить

Краткий гайд: как мод попадает в [TNI-ModManager-Plus](https://github.com/DefaultUsernameWasAleadyTaken/TNI-ModManager-Plus), как выкатить новую версию и как убрать мод из каталога.

Подробности упаковки и тегов — [releasing.md](releasing.md). Решение по каталогу — [ADR-004](decisions.md).

## Как MM+ находит мод

1. Репозиторий есть в `mod-sources.json` у **TNI-ModManager-Plus** (для этой библиотеки уже настроено).
2. В репо есть GitHub Release с тегом **`<modId>-vX.Y.Z`** (пример: `cool-mod-v1.0.0`).
3. У релиза есть **zip-asset**: внутри zip — папка `<modId>/`, не плоский список файлов.

После появления релиза в менеджере нажать **Обновить** (или дождаться автообновления каталога).

**Не попадают в MM+:** [`templates/`](../templates/) (заготовки) и [`toolkit/mods/`](../toolkit/mods/) (примеры upstream) — у них нет релизов/`release-*.yml`.

---

## Создать новый мод

Работайте в ветке **`beta`**.

1. **Скопировать шаблон**
   ```bash
   cp -r templates/mod mods/<mod-id>
   ```
   Замените все `my-mod` / `My Mod` на свой id и название.

2. **Уникальный id** — одно и то же значение везде:
   - имя папки `mods/<mod-id>/`
   - `ID:` в `metadata.yaml`
   - `"id"` в `mod.jsonc`

3. **Файлы мода** (как у upstream):
   - `entry.lua` — логика; конфиг между маркерами `MOD CONFIGURATION`
   - `mod.jsonc` — id, version, dependencies
   - `metadata.yaml` — Version, описание, Parameters
   - `README.md` — кратко для людей

4. **Версия** — SemVer без префикса `v`, одинаковая в `metadata.yaml` и `mod.jsonc` (например `0.1.0`).

5. **Workflow релиза**
   ```bash
   cp templates/release-mod.yml.example .github/workflows/release-<mod-id>.yml
   ```
   Замените все `__MOD_ID__` на ваш id. Файл `.example` в `templates/` GitHub **не** запускает.

6. **Релиз** — после merge в `main`: push в `mods/<mod-id>/**` на **`main`** или `workflow_dispatch` создаст тег и zip.  
   Ручной вариант: [releasing.md](releasing.md).

7. **Проверка:** Releases → тег `<mod-id>-vX.Y.Z` + zip. В MM+ — **Обновить**.

---

## Обновить мод

Поток: **`beta` (разработка) → merge в `main` → CI-релиз → MM+ Обновить**.

1. Правите код/конфиг в `mods/<mod-id>/` на **`beta`**.
2. Поднимите версию в **`metadata.yaml`** и **`mod.jsonc`**.
3. Закоммитьте и запушьте в **`beta`**, затем смержите в **`main`**.
4. Workflow `release-<mod-id>.yml` слушает только **`main`**. CI создаст/обновит Release с тегом `<mod-id>-v<версия>`.
5. В MM+: **Обновить**.

Без merge в `main` релиза не будет. Всегда бампьте SemVer при осмысленном релизе.

---

## Удалить мод (убрать из каталога)

1. **Удалить GitHub Releases и теги** (`<mod-id>-v*`):
   ```bash
   gh release delete <mod-id>-vX.Y.Z --yes
   git push origin :refs/tags/<mod-id>-vX.Y.Z
   ```
2. **Убрать исходники** (по желанию): `mods/<mod-id>/` и `.github/workflows/release-<mod-id>.yml`.
3. Уже установленный у игроков мод останется локально — удалить вручную из userdata `mods/`.

---

## Чеклист перед релизом

- [ ] Папка = `ID` = `mod.jsonc` → `id`
- [ ] Версии в yaml и jsonc совпадают
- [ ] Есть `release-<mod-id>.yml` (из `templates/release-mod.yml.example`)
- [ ] Смержено в `main`, тег `<mod-id>-vX.Y.Z` + zip на Releases
- [ ] В MM+ нажали **Обновить**

Шаблон: [`templates/mod/`](../templates/mod/) · workflow: [`templates/release-mod.yml.example`](../templates/release-mod.yml.example).
