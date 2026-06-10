-- Keymaps which must be loaded after any lazy plugins

local set_keymap = require("config.utils").set_keymap
local safe_require = require("config.utils").safe_require

local M = {}

-- Called in ../../init.lua; loaded when Neovim is launched
function M.set_global_keymaps()
    -- ========
    -- vim.pack
    -- ========
    set_keymap("n", "<leader>up", ":lua vim.pack.update()<CR>", { desc = "Update all plugins" })
    -- ==========
    -- mini.files
    -- ==========
    set_keymap("n", "<leader>o", ":lua MiniFiles.open()<CR>", { desc = "Open mini.files" })

    -- =======
    -- fzf-lua
    -- =======
    local fzf_lua = safe_require("fzf-lua")
    if fzf_lua then
        set_keymap("n", "<leader>lf", function() fzf_lua.files() end, { desc = "FZF files" })
        set_keymap("n", "<leader>lg", function() fzf_lua.live_grep() end, { desc = "FZF live grep" })
        set_keymap("n", "<leader>lb", function() fzf_lua.buffers() end, { desc = "FZF buffers" })
        set_keymap("n", "<leader>lh", function() fzf_lua.help_tags() end, { desc = "FZF help tags" })
        set_keymap("n", "<leader>ld", function() fzf_lua.diagnostics_document() end, { desc = "FZF diagnostics document" })
        set_keymap("n", "<leader>lD", function() fzf_lua.diagnostics_workspace() end, { desc = "FZF diagnostics workspace" })
    end

    -- ========
    -- gitsigns
    -- ========
    local gitsigns = safe_require("gitsigns")
    if gitsigns then
        set_keymap("n", "]h", function() gitsigns.next_hunk() end, { desc = "Next git hunk" })
        set_keymap("n", "[h", function() gitsigns.prev_hunk() end, { desc = "Previous git hunk" })
        set_keymap("n", "<leader>hs", function() gitsigns.stage_hunk() end, { desc = "Stage git hunk" })
        set_keymap("n", "<leader>hr", function() gitsigns.reset_hunk() end, { desc = "Reset git hunk" })
        set_keymap("n", "<leader>hp", function() gitsigns.preview_hunk() end, { desc = "Preview git hunk" })
        set_keymap("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Git blame line" })
        set_keymap("n", "<leader>hB", function() gitsigns.toggle_current_line_blame() end, { desc = "Toggle inline blame" })
        set_keymap("n", "<leader>hd", function() gitsigns.diffthis() end, { desc = "Diff this" })
    end

    -- ===================
    -- tree-sitter-manager
    -- ===================
    set_keymap("n", "<leader>ts", ":TSManager<CR>", { desc = "Open tree-sitter parser manager" })

    -- =====
    -- mason
    -- =====
    set_keymap("n", "<leader>M", ":Mason<CR>", { desc = "Open Mason" })

    -- ============
    -- conform.nvim
    -- ============
    local conform = safe_require("plugins.conform")
    if conform then
        set_keymap("n", "<leader>ci", ":ConformInfo<CR>", { desc = "Open conform.nvim info" })
        set_keymap("n", "<leader>df", function() conform.set_format_on_save(false, false) end, { desc = "Disable format on save for buffer" })
        set_keymap("n", "<leader>ef", function() conform.set_format_on_save(true, false) end, { desc = "Enable format on save for buffer" })
        set_keymap("n", "<leader>dF", function() conform.set_format_on_save(false, true) end, { desc = "Disable format on save globally" })
        set_keymap("n", "<leader>eF", function() conform.set_format_on_save(true, true) end, { desc = "Enable format on save globally" })
    end
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
