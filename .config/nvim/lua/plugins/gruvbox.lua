local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/ellisonleao/gruvbox.nvim"
})

safe_require("gruvbox").setup({})
vim.cmd.colorscheme("gruvbox")
