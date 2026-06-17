local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
})

safe_require("nvim-web-devicons").setup({})
