-- Keymaps which can/must be loaded before any lazy plugins

-- Set up shorthand
local opts = { noremap = true, silent = true }

-- Remap spacebar as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>ch", ":checkhealth<CR>", opts)
vim.keymap.set("n", "<leader>ls", ":checkhealth vim.lsp<CR>", opts)

-- Remain in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Stop yank rewrite on paste
vim.keymap.set("v", "p", '"_dP', opts)
