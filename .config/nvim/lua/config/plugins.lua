local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

-- Path to plugins dir
local config_path = vim.fn.stdpath("config") .. "/lua/" .. globals.plugins_dir

-- Alert if plugins dir doesn't exist
if vim.fn.isdirectory(config_path) == 0 then
    vim.notify("No plugin directory at " .. config_path, vim.log.levels.ERROR)
    return
end

-- Track plugins which have been loaded
local loaded_plugins = {}

-- First pass: load high-priority plugins in order
for _, filename in ipairs(globals.high_priority_plugins) do
    local plugin_name = globals.plugins_dir .. "." .. filename
    -- Require plugin to load it
    safe_require(plugin_name)
    loaded_plugins[plugin_name] = true
end

-- Second pass: scan and load all other plugins automatically
local files = vim.fn.readdir(config_path)
for _, file in ipairs(files) do
    if file:match("%.lua$") then
        local plugin_name = globals.plugins_dir .. "." .. file:sub(1, -5)
        -- Require plugin to load it if it hasn't been loaded already
        if not loaded_plugins[plugin_name] then
            safe_require(plugin_name)
        end
    end
end
