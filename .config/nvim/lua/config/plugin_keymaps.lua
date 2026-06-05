-- Keymaps which must be loaded after any lazy plugins

-- Set up shorthand
local opts = { noremap = true, silent = true }

-- lazy: open UI
vim.keymap.set("n", "<leader>L", ":Lazy<CR>", opts)
