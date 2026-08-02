# Релизы модов — TNI-MM-Mods

Как выложить мод так, чтобы его увидел [TNI-ModManager-Plus](https://github.com/DefaultUsernameWasAleadyTaken/TNI-ModManager-Plus).

**Жизненный цикл (создать / обновить / удалить):** [mod-lifecycle.md](mod-lifecycle.md).

## Коротко

1. Мод в `mods/<mod-id>/` с `entry.lua`, `mod.jsonc`, `metadata.yaml`, `README.md`.
2. Версия в `metadata.yaml` / `mod.jsonc` (SemVer, например `0.1.0`).
3. GitHub Release:
   - **тег:** `<mod-id>-v<version>` (пример: `cool-mod-v1.0.0`)
   - **asset:** zip, внутри которого папка `<mod-id>/` (не плоский корень файлов)
4. Репозиторий должен быть в `mod-sources.json` у Mod Manager Plus.

**Поток релиза:** разработка на **`beta`** → merge в **`main`** → CI `release-*.yml` (push в `main` или `workflow_dispatch`) → в MM+ **Обновить**.  
Релиз **только из `main`**. Push в `beta` релиз **не** создаёт.

## Шаблоны (не релизятся)

| Путь | Зачем |
|------|--------|
| [`templates/mod/`](../templates/mod/) | заготовка файлов мода |
| [`templates/release-mod.yml.example`](../templates/release-mod.yml.example) | скопировать в `.github/workflows/release-<mod-id>.yml`, заменить `__MOD_ID__` |

`templates/`, `toolkit/mods/` и `examples/` **не** публикуются в MM+.

Ручной пакет (с `main`):

```bash
cd mods
zip -r ../<mod-id>-0.1.0.zip <mod-id>/ -x "<mod-id>/.*"
cd ..
gh release create <mod-id>-v0.1.0 <mod-id>-0.1.0.zip \
  --title "<mod-id> v0.1.0" \
  --notes "…" \
  --target main
```

## Новый мод — чеклист

Полный гайд: [mod-lifecycle.md](mod-lifecycle.md). Кратко:

1. `cp -r templates/mod mods/<mod-id>` + заменить `my-mod`.
2. Уникальный `ID` / папка / `mod.jsonc` → `id`.
3. Workflow из `templates/release-mod.yml.example`.
4. Merge в `main` → «Обновить» в Mod Manager Plus.

## Toolkit / examples sync (не релизы модов)

Синхронизация `toolkit/` + `examples/` — [`sync-toolkit.yml`](../.github/workflows/sync-toolkit.yml) (`scripts/sync-all.sh`). См. [architecture.md](architecture.md).

## Связанное

- [mod-lifecycle.md](mod-lifecycle.md) · [decisions.md](decisions.md) (ADR-004) · [AGENTS.md](../AGENTS.md) · [README.md](../README.md)
