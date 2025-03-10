require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {
        light0 = "#ebdbb2",
    },
    overrides = {},
    dim_inactive = true,
    transparent_mode = false,
})

if os.getenv("BASE16_THEME") == "max-light" then
    vim.o.background = "light"
else
    vim.o.background = "dark"
end

local colourscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)

if not status_ok then
    vim.notify("ERROR: Colour scheme " .. colourscheme .. " not found.")
    return
end
