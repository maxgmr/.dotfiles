---@type vim.lsp.Config
local config = {
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                buildScripts = { enable = true },
                features = "all",
            },
            check = {
                command = "clippy",
                allTargets = true,
            },
            checkOnSave = true,
            diagnostics = {
                disabled = {},
                enable = true,
                styleLints = {
                    enable = true,
                },
            },
            procMacro = { enable = true },
        },
    },
}
vim.lsp.config("rust_analyzer", config)
