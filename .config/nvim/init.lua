-- Define Python host path (requires pynvim to be installed)
-- luacheck: ignore 122
vim.g.python3_host_prog = "/usr/bin/python3"

-- Ensure basic options and keymaps are set up before anything else
require("config.options")
require("config.base_keymaps")
-- Ensure native Neovim LSP settings are set and LSPs are configured
-- before loading any plugins
require("config.lsp")

require("config.plugins")

-- Set up keymaps reliant on specific plugins
require("config.plugin_keymaps").set_global_keymaps()
