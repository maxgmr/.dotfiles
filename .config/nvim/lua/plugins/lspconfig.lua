local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

-- Configure and activate tools once tool installation/update is
-- complete
vim.api.nvim_create_autocmd("User", {
    desc = "Configure/activate tools once insallation complete",
    group = vim.api.nvim_create_augroup("UserMason", { clear = true }),
    pattern = "MasonToolsUpdateCompleted",
    callback = function()
        -- Configure and activate installed tools
        vim.pack.add({
            "https://github.com/neovim/nvim-lspconfig",
            "https://github.com/mason-org/mason-lspconfig.nvim",
        })

        -- Load custom LSP configurations
        for _, config in ipairs(globals.lsp_configs) do
            pcall(require, "lsps." .. config:gsub("-", "_"))
        end

        safe_require("mason-lspconfig").setup({})
    end,
})
