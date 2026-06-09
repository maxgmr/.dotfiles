local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    desc = "Linebreak and spellcheck on markdown and text files",
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})
