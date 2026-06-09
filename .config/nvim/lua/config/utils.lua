local M = {}

function M.safe_require(module_name)
    local status_ok, err = pcall(require, module_name)
    if not status_ok then
        vim.notify(
            string.format("Error loading %s:\n%s", module_name, err),
            vim.log.levels.ERROR
        )
    end
    return status_ok
end

return M
