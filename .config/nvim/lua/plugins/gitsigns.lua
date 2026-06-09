local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim"
})

safe_require("gitsigns").setup({
    signcolumn = true,
    current_line_blame = false,
})
