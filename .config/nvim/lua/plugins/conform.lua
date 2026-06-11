local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/stevearc/conform.nvim",
        })
        safe_require("conform").setup({
            formatters_by_ft = globals.formatters,
            format_on_save = function(bufnr)
                -- Skip formatting if disabled in the current buffer or globally
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 10000, lsp_format = "fallback" }
            end,
        })

        -- Path to formatters dir
        local formatters_path = vim.fn.stdpath("config") .. "/lua/" .. globals.formatters_dir

        -- Configure all formatters
        local files = vim.fn.readdir(formatters_path)
        for _, file in ipairs(files) do
            if file:match("%.lua$") then
                safe_require(globals.formatters_dir .. "." .. file:sub(1, -5))
            end
        end
    end,
})

-- Export function to set formatting on save
local M = {}
function M.set_format_on_save(state, is_global)
    if is_global then
        -- luacheck: ignore 122
        vim.g.disable_autoformat = not state
    else
        -- luacheck: ignore 122
        vim.b.disable_autoformat = not state
    end

    local status = state and "enabled" or "disabled"
    local scope = is_global and "globally" or "for buffer"
    vim.notify("Format on save " .. status .. " " .. scope, vim.log.levels.INFO)

    vim.api.nvim_exec_autocmds("User", {
        pattern = "FormatToggle",
        modeline = false,
        data = {
            is_global = is_global,
            is_enabled = state,
            bufnr = vim.api.nvim_get_current_buf(),
        },
    })
end
return M
