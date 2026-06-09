---@type vim.lsp.Config
local config = {
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                cargo = {
                    features = "all",
                },
                check = {
                    command = "clippy",
                },
                styleLints = {
                    enable = true,
                },
            },
        }
    }
}
vim.lsp.config("rust_analyzer", config)
