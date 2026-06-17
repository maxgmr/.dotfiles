-- Keymaps which can/must be loaded before any plugins

local set_keymap = require("config.utils").set_keymap

-- Remap spacebar as leader key
set_keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

set_keymap("n", "<leader>ch", ":checkhealth<CR>", { desc = "Check health" })
set_keymap("n", "<leader>ls", ":checkhealth vim.lsp<CR>", { desc = "Check LSP health" })

set_keymap("n", "<leader>cl", ":nohlsearch<CR>", { desc = "Clear search highlights" })

set_keymap("v", "<", "<gv", { desc = "Remain in indent mode" })
set_keymap("v", ">", ">gv", { desc = "Remain in indent mode" })

set_keymap("v", "p", '"_dP', { desc = "Stop yank rewrite on paste" })

set_keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
set_keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

set_keymap("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end, { desc = "Copy full file path" })

set_keymap("n", "<leader>dd", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

set_keymap({ "n", "t" }, "<C-\\>", function()
    require("config.terminal").toggle()
end, { desc = "Toggle floating terminal" })
