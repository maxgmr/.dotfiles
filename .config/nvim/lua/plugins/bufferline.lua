local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

vim.schedule(function()
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
end)
