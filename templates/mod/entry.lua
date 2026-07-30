-- ===== MOD CONFIGURATION START =====
-- This section is parsed and modified by ModManager
-- Do not remove the configuration markers

local config = {
    greeting = "Hello from my-mod!",
    debug_logging = true
}

-- ===== MOD CONFIGURATION END =====

-- Шаблон: после копирования замените my-mod на свой mod-id везде.

function on_mod_load()
    if config.debug_logging then
        print("[my-mod] on_mod_load: " .. tostring(config.greeting))
    end
end

function on_mods_loaded()
    print("[my-mod] " .. tostring(config.greeting))
    if ModApiV1 and ModApiV1.sanity then
        ModApiV1.sanity()
    end
end

function on_mod_reload()
    print("[my-mod] reloaded: " .. tostring(config.greeting))
end
