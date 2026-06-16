local M = {}

-- Master table for LSP configurations
M.configs = {}

-- Set up a given server
function M.setup(server_name)
    if M.configs[server_name] then
        vim.lsp.config(server_name, M.configs[server_name])
    end
    vim.lsp.enable(server_name)
end

return M
