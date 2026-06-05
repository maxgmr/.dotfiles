-- :help options
local options = {
    -- remove backups after overwriting a file
    backup = false,
    writebackup = true,
    -- Milliseconds of inactivity before writing swap file
    updatetime = 2000,

    -- use system clipboard
    clipboard = "unnamedplus",

    -- persist undo history even after closing a file
    undofile = true,

    -- "" to not convert file encoding, "utf-8" to convert to UTF-8
    fileencoding = "utf-8",

    -- enable 24-bit RGB
    termguicolors = true,

    -- show relative line numbers
    number = true,
    relativenumber = true,
    numberwidth = 4,
    -- always have dedicated margin for Git changes, LSP warnings, etc.
    signcolumn = "yes",

    -- Fallback visibility for any hard tabs that sneak in
    tabstop = 4,
    -- Tabs count for 4 spaces when editing
    softtabstop = 4,
    -- Shift 4 spaces for (auto)indenting
    shiftwidth = 4,
    -- Use spaces instead of tabs
    expandtab = true,

    -- Start scrolling before hitting the top/bottom of the window
    scrolloff = 12,

    showmode = false,

    -- show completions even if one match and don't pre-select
    completeopt = { "menuone", "noselect" },

    -- generate smallest possible diff
    diffopt = { 
        "algorithm:minimal",
        "closeoff",
        "filler",
        "internal",
        "linematch:60"
    },

    belloff = "all",

    -- show search as it's being typed
    incsearch = true,
    -- highlight search pattern matches
    hlsearch = true,
    -- ignore case in when searching
    ignorecase = true,
    -- stop ignoring case if search contains upper case
    smartcase = true,

    -- always put new windows to the bottom right
    splitbelow = true,
    splitright = true,

    -- Add <EOL> if missing from end of file when writing
    fixendofline = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end
