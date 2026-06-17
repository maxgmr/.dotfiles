-- Set up a floating terminal
local globals = require("config.globals")

local M = {}

local state = { buf = -1, win = -1 }

local augroup = vim.api.nvim_create_augroup("UserTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Clean up terminal UI",
    group = augroup,
    -- luacheck: ignore 122
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    desc = "Wipe state if terminal is exited manually",
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 and vim.api.nvim_buf_is_valid(state.buf) then
            vim.api.nvim_buf_delete(state.buf, { force = true })
        end
        state.buf = -1
        state.win = -1
    end,
})

function M.toggle()
    -- If window is open, hide it and stop execution
    if vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_hide(state.win)
        return
    end

    -- Create a hidden buffer if one doesn't exist
    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[state.buf].bufhidden = "hide"
    end

    -- Calculate dimensions based on screen size
    local width = math.floor(vim.o.columns * globals.term_width_percent)
    local height = math.floor(vim.o.lines * globals.term_height_percent)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open the floating window
    state.win = vim.api.nvim_open_win(state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    -- Apply highlights
    vim.wo[state.win].winblend = 0
    vim.wo[state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    -- Spawn terminal natively if it's not already running
    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.fn.jobstart(os.getenv("SHELL") or "sh", { term = true })
    end

    -- Automatically drop into insert mode
    vim.cmd("startinsert")
end

return M
