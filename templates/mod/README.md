# My Mod (шаблон)

Скопируйте эту папку в `mods/<mod-id>/` и замените все вхождения `my-mod` / `My Mod` на свой id и название.

Не кладите шаблон в `mods/` под именем `my-mod`, если не собираетесь его релизить — рабочий каталог опубликованных модов только `mods/`.

## Быстрый старт

```bash
cp -r templates/mod mods/<mod-id>
# затем правьте id/version и добавьте workflow из templates/release-mod.yml.example
```

См. [docs/mod-lifecycle.md](../../docs/mod-lifecycle.md).
