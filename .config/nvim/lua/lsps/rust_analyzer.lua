---@type vim.lsp.Config
local config = {
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
            check = {
                command = "clippy",
            },
            diagnostics = {
                styleLints = {
                    enable = true,
                },
            },
        },
    },
}
vim.lsp.config("rust_analyzer", config)
