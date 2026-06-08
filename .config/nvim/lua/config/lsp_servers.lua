return {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
    ---@type vim.lsp.Config
    lua_ls = {
        ---@type lspconfig.settings.lua_ls
        settings = {}
    },

    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/rust_analyzer.lua
    ---@type vim.lsp.Config
    rust_analyzer = {
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
                }
            }
        },
    }
}
