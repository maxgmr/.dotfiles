local globals = require("config.globals")

-- Diagnostic UI config
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    update_in_insert = false, -- update only upon leaving insert
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = globals.error_symbol,
            [vim.diagnostic.severity.WARN] = globals.warning_symbol,
            [vim.diagnostic.severity.HINT] = globals.hint_symbol,
            [vim.diagnostic.severity.INFO] = globals.info_symbol,
        },
    },
    float = {
        source = true,
        header = "",
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    desc = "Things to do when a particular LSP attaches",
    callback = function(ev)
        -- Load keymaps
        require("config.plugin_keymaps").set_lsp_keymaps(ev.buf)
    end,
})
