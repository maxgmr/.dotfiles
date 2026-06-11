local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/mfussenegger/nvim-lint",
        })

        safe_require("lint").linters_by_ft = globals.linters

        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
            desc = "Run linter on buffer write",
            callback = function()
                safe_require("lint").try_lint()
            end,
        })
    end,
})
