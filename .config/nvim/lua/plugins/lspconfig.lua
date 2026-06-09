local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

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
        }
    },
    float = {
        source = true,
        header = "",
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    desc = "Things to do when a particular LSP attaches",
    callback = function(ev)
        -- Load keymaps
        safe_require("config.plugin_keymaps").set_lsp_keymaps(ev.buf)
    end,
})

-- Path to LSPs dir
local lsps_path = vim.fn.stdpath("config") .. "/lua/" .. globals.lsps_dir

-- Load and enable all LSPs in the LSP directory
local files = vim.fn.readdir(lsps_path)
for _, file in ipairs(files) do
    if file:match("%.lua$") then
        local module_name = globals.lsps_dir .. "." .. file:sub(1, -5)
        safe_require(module_name)
    end
end
