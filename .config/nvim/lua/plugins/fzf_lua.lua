local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua"
})
safe_require("fzf-lua").setup({})
