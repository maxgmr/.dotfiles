local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

for _, plugin in ipairs(globals.plugins) do
    safe_require("plugins." .. plugin)
end
