local M = {}

M.name = "rust_analyzer"

function M.configure()
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
    vim.lsp.config(M.name, config)
end

return M
