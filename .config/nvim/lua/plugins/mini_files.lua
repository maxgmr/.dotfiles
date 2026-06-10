local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/nvim-mini/mini.files",
})
safe_require("mini.files").setup({
    mappings = {
        close = "<leader>o",
        go_in_plus = "<Enter>",
    },
})
