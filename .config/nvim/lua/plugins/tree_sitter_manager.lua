vim.pack.add({
    "https://github.com/romus204/tree-sitter-manager.nvim"
})
require("config.utils").safe_require("tree-sitter-manager").setup({
    ensure_installed = "all",
    auto_install = false,
    highlight = true,
    -- Use regex highlighting for specific languages
    nolighlight = {
    },
})
