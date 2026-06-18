local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

local function load_plugin()
    vim.pack.add({
        "https://github.com/akinsho/bufferline.nvim",
    })

    safe_require("bufferline").setup({
        options = {
            mode = "buffers",

            themable = true,

            numbers = "none",

            right_mouse_command = nil,
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,

            show_buffer_icons = true,
            show_buffer_close_icons = false,
            show_close_icon = false,

            sort_by = "directory",

            indicator = { style = "none" },

            modified_icon = globals.modified_symbol,

            offsets = {},

            hover = { enabled = false },

            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and globals.error_symbol or globals.warning_symbol
                return " " .. icon .. count
            end,

            always_show_bufferline = false,
        },
    })
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
    desc = "Lazy load bufferline.nvim when a second buffer is opened",
    group = vim.api.nvim_create_augroup("BufferlineLazyLoad", { clear = true }),
    callback = function()
        -- If more than one standard buffer, load the plugin
        if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
            load_plugin()
            vim.cmd.redrawtabline()
            -- Returning true automatically deletes the autocmd
            return true
        end
    end,
})
