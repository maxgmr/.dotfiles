-- Keymaps which must be loaded after any lazy plugins

local set_keymap = require("config.utils").set_keymap

-- Set up shorthand
local opts = { silent = true }

local M = {}

-- Called in ../../init.lua; loaded when Neovim is launched
function M.set_global_keymaps()
    set_keymap("n", "<leader>o", ":lua MiniFiles.open()<CR>", { desc = "Open mini.files" })
end

-- Called in ../plugins/lspconfig.lua; lazily loaded when an LSP is
function M.set_lsp_keymaps(bufnr)
    set_keymap("n", "<leader>dc", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
    set_keymap("n", "<leader>de", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
    set_keymap("n", "<leader>im", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
    set_keymap("n", "<leader>td", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
    set_keymap("n", "<leader>rf", vim.lsp.buf.references, { desc = "List all references", buffer = bufnr })

    set_keymap("n", "gd", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Jump to next diagnostic", buffer = bufnr })
    set_keymap("n", "gD", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Jump to previous diagnostic", buffer = bufnr })
    set_keymap("n", "gl", function() vim.diagnostic.open_float() end, { desc = "View diagnostics", buffer = bufnr })

    set_keymap("n", "<leader>hh", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })

    set_keymap({"n", "x"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Select a code action", buffer = bufnr })

    set_keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
end

return M
