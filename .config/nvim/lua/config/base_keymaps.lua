-- Keymaps which can/must be loaded before any plugins

local set_keymap = require("config.utils").set_keymap

-- Remap spacebar as leader key
set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

set_keymap("n", "<leader>ch", ":checkhealth<CR>", { desc = "Check health" })
set_keymap("n", "<leader>ls", ":checkhealth vim.lsp<CR>", { desc = "Check LSP health" })

set_keymap("n", "<leader>cl", ":nohlsearch<CR>", { desc = "Clear search highlights" })

set_keymap("v", "<", "<gv", { desc = "Remain in indent mode" })
set_keymap("v", ">", ">gv", { desc = "Remain in indent mode" })

-- Stop yank rewrite on paste
set_keymap("v", "p", '"_dP', { desc = "Stop yank rewrite on paste" })
