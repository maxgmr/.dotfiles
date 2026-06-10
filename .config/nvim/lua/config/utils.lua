local globals = require("config.globals")

local M = {}

-- Attempt to load module; print error on failure
function M.safe_require(module_name)
    local status_ok, result = pcall(require, module_name)
    if not status_ok then
        vim.notify(string.format("Error loading %s:\n%s", module_name, result), vim.log.levels.ERROR)
        return nil
    end
    return result
end

-- Set keymap with default options
function M.set_keymap(mode, lhs, rhs, opts)
    local options = globals.default_keymap_opts
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

return M
