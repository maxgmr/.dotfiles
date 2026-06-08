-- Keymaps which must be loaded after any lazy plugins

-- Set up shorthand
local opts = { silent = true }

local M = {}

-- Called in ../../init.lua; loaded when Neovim is launched
function M.set_global_keymaps()
    -- lazy: open UI
    vim.keymap.set("n", "<leader>L", ":Lazy<CR>", opts)

    -- mini.files: open
    vim.keymap.set("n", "<leader>o", ":lua MiniFiles.open()<CR>", opts)
end

-- Called in ../plugins/lspconfig.lua; lazily loaded when an LSP is
function M.set_lsp_keymaps(bufnr)
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>dc", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>de", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>im", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "gd", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "gD", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)

    vim.keymap.set("n", "<leader>hh", vim.lsp.buf.hover, opts)

    vim.keymap.set({"n", "x"}, "<leader>ca", vim.lsp.buf.code_action, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

return M
