vim.pack.add({
    "https://github.com/nvim-mini/mini.files"
})
require("mini.files").setup({
    mappings = {
        close = "<leader>o",
        go_in_plus = "<Enter>",
    }
})
