# Templates

Заготовки для новых модов. **Не релизятся** и **не попадают в Mod Manager Plus** (лежат вне `mods/` и без активного workflow).

| Путь | Назначение |
|------|------------|
| [`mod/`](mod/) | структура мода (`entry.lua`, `mod.jsonc`, `metadata.yaml`, `README.md`) |
| [`release-mod.yml.example`](release-mod.yml.example) | скопировать в `.github/workflows/release-<mod-id>.yml` и заменить `__MOD_ID__` |

```bash
cp -r templates/mod mods/<mod-id>
# заменить my-mod → <mod-id> в файлах мода
cp templates/release-mod.yml.example .github/workflows/release-<mod-id>.yml
# заменить __MOD_ID__ → <mod-id> в workflow
```

Дальше: [docs/mod-lifecycle.md](../docs/mod-lifecycle.md).
