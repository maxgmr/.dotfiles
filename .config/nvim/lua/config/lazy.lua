-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify("ERROR: Failed to load lazy.nvim.")
    return
end
lazy.setup({
    spec = {
        { import = "plugins" },
    },
    -- Colourscheme used when installing plugins
    install = { colorscheme = { "retrobox" } },
    -- Automatically check for plugin updates
    checker = { enabled = true },
})
