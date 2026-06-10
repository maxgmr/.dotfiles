-- Set up place to store undo history if it doesn't exist
local undodir = vim.fn.expand(require("config.globals").undodir)
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- :help options
local options = {
    -- remove backups after overwriting a file
    backup = false,
    writebackup = true,

    -- Save undos to directory
    undofile = true,
    undodir = undodir,

    -- Milliseconds of inactivity before writing swap file
    updatetime = 500,
    -- Milliseconds of inactivity before timing out command
    timeoutlen = 500,

    -- use system clipboard
    clipboard = "unnamedplus",

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

    -- highlight matching brackets
    showmatch = true,

    -- Fallback visibility for any hard tabs that sneak in
    tabstop = 4,
    -- Tabs count for 4 spaces when editing
    softtabstop = 4,
    -- Shift 4 spaces for (auto)indenting
    shiftwidth = 4,
    -- Use spaces instead of tabs
    expandtab = true,
    -- Smart auto-indent
    smartindent = true,
    -- Copy indent from current line
    autoindent = true,

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
        "linematch:60",
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

    -- Folding requires treesitter available at runtime; safe fallback
    -- if not
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    -- Start with all folds open
    foldlevel = 99,

    -- always put new windows to the bottom right
    splitbelow = true,
    splitright = true,

    -- Add <EOL> if missing from end of file when writing
    fixendofline = true,

    -- Increase max memory
    maxmempattern = 20000,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end
