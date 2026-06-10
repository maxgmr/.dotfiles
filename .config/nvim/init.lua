-- Ensure basic options and keymaps are set up before anything else
require("config.options")
require("config.base_keymaps")
-- Ensure native Neovim LSP settings are set and LSPs are configured
-- before loading any plugins
require("config.lsp")

require("config.plugins")

-- Set up keymaps reliant on specific plugins
require("config.plugin_keymaps").set_global_keymaps()
