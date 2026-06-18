local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/nvim-mini/mini.pairs",
})

safe_require("mini.pairs").setup({})
