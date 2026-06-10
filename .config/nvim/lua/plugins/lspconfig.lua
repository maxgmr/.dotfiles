local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- Automatically activate installed LSPs with mason-lspconfig
safe_require("mason-lspconfig").setup({})
