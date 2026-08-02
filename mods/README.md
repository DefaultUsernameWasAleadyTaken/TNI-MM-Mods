# Mods

Сюда кладутся **публикуемые** моды этой библиотеки.

Шаблоны для копирования — в [`templates/`](../templates/) (не релизятся, не видны MM+).  
Примеры официального kit — [`toolkit/mods/`](../toolkit/mods/).  
Community-примеры — [`examples/`](../examples/).

Структура мода:

```
mods/<mod-id>/
├── entry.lua
├── mod.jsonc
├── metadata.yaml
└── README.md
```

Новый мод:

```bash
cp -r templates/mod mods/<mod-id>
# заменить my-mod → <mod-id>
cp templates/release-mod.yml.example .github/workflows/release-<mod-id>.yml
# заменить __MOD_ID__ → <mod-id>
```

Подробнее: [docs/mod-lifecycle.md](../docs/mod-lifecycle.md).
