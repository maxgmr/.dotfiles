local M = {}

M.name = "lua_ls"

function M.configure()
    ---@type vim.lsp.Config
    local config = {
        ---@type lspconfig.settings.lua_ls
        settings = {}
    }
    vim.lsp.config(M.name, config)
end

return M
