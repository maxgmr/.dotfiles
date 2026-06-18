local globals = require("config.globals")

local M = {}

-- Dynamic theme highlights
local function setup_highlights()
    local get_hl = function(name)
        return vim.api.nvim_get_hl(0, { name = name, link = false })
    end

    local stl = get_hl("StatusLine")
    local normal = get_hl("Normal")
    local comment = get_hl("Comment")

    -- Extract standard terminal colours
    local red = get_hl("Keyword")
    local green = get_hl("String")
    local yellow = get_hl("DiagnosticWarn")
    local blue = get_hl("Identifier")

    local error = get_hl("DiagnosticError")
    local warn = get_hl("DiagnosticWarn")
    local info = get_hl("DiagnosticInfo")
    local hint = get_hl("DiagnosticHint")

    -- Autoformat
    vim.api.nvim_set_hl(0, "SlAutoformatEnabled", { fg = normal.bg, bg = green.fg })
    vim.api.nvim_set_hl(0, "SlAutoformatDisabled", { fg = normal.bg, bg = stl.fg })

    -- Git branch
    vim.api.nvim_set_hl(0, "SlGitBranch", { fg = normal.bg, bg = blue.fg })

    -- Git diff
    vim.api.nvim_set_hl(0, "SlGitDiffAdded", { fg = green.fg, bg = stl.bg })
    vim.api.nvim_set_hl(0, "SlGitDiffChanged", { fg = yellow.fg, bg = stl.bg })
    vim.api.nvim_set_hl(0, "SlGitDiffRemoved", { fg = red.fg, bg = stl.bg })

    -- Diagnostics
    vim.api.nvim_set_hl(0, "SlError", { fg = normal.bg, bg = error.fg })
    vim.api.nvim_set_hl(0, "SlWarn", { fg = normal.bg, bg = warn.fg })
    vim.api.nvim_set_hl(0, "SlInfo", { fg = normal.bg, bg = info.fg })
    vim.api.nvim_set_hl(0, "SlHint", { fg = normal.bg, bg = hint.fg })

    -- Path components
    vim.api.nvim_set_hl(0, "SlPathDim", { fg = comment.fg, bg = stl.bg })
    vim.api.nvim_set_hl(0, "SlPathBright", { fg = stl.fg, bg = stl.bg })

    -- -- File Size
    -- vim.api.nvim_set_hl(0, "SlSize", { fg = normal.bg, bg = blue.fg })

    -- Location
    vim.api.nvim_set_hl(0, "SlLocation", { fg = normal.bg, bg = blue.fg })

    -- Progress
    vim.api.nvim_set_hl(0, "SlProgress", { fg = normal.bg, bg = green.fg })
end
-- Re-run highlight extraction whenever the colour scheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Update statusline colours when the colour scheme changes",
    group = vim.api.nvim_create_augroup("StatusLineHighlights", { clear = true }),
    callback = setup_highlights,
})
-- Run once on startup
setup_highlights()

-- Track dynamically created icon highlight groups to avoid needless
-- recreation
local created_icon_hls = {}
-- Combine an icon colour with the background colour of the given
-- highlight.
local function get_or_create_icon_hl(icon_hl, bg_hl_name)
    local custom_hl_name = "Sl" .. bg_hl_name .. "_" .. icon_hl

    -- Return the highlight if already built
    if created_icon_hls[custom_hl_name] then
        return custom_hl_name
    end

    -- Extract original attrs
    local icon_attr = vim.api.nvim_get_hl(0, { name = icon_hl, link = false })
    local bg_attr = vim.api.nvim_get_hl(0, { name = bg_hl_name, link = false })

    -- Fallback safety check if theme hasn't loaded yet
    local fg_colour = icon_attr.fg or icon_attr.ctermfg
    local bg_colour = bg_attr.bg or bg_attr.ctermbg

    -- Create new hybrid group: icon FG + block BG
    vim.api.nvim_set_hl(0, custom_hl_name, {
        fg = fg_colour,
        bg = bg_colour,
        bold = icon_attr.bold,
    })

    created_icon_hls[custom_hl_name] = true
    return custom_hl_name
end

-- Cache for expensive lookups (file size, path, and icons)
local cache = {}
-- Update cache on specific events to avoid I/O during redraws
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "TextChanged" }, {
    desc = "Update statusline cache",
    group = vim.api.nvim_create_augroup("StatusLineCache", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        if not cache[bufnr] then
            cache[bufnr] = {}
        end

        local file = vim.api.nvim_buf_get_name(bufnr)
        if file and file ~= "" then
            -- -- Cache file size
            -- local size = vim.fn.getfsize(file)
            -- if size <= 0 then
            --     cache[bufnr].size = ""
            -- elseif size < 1024 then
            --     cache[bufnr].size = size .. "B"
            -- elseif size < 1048576 then
            --     cache[bufnr].size = string.format("%.1fKB", size / 1024)
            -- elseif size < 1073741824 then
            --     cache[bufnr].size = string.format("%.1fMB", size / 1048576)
            -- else
            --     cache[bufnr].size = string.format("%.1fGB", size / 1073741824)
            -- end

            -- Cache path
            local rel_path = vim.fn.fnamemodify(file, ":~:.")
            local tail = vim.fn.fnamemodify(rel_path, ":t")
            local head = vim.fn.fnamemodify(rel_path, ":h")
            cache[bufnr].tail = tail
            cache[bufnr].dir = (head == "." or head == "") and "" or (head .. "/")
        else
            cache[bufnr].size = ""
            cache[bufnr].tail = ""
            cache[bufnr].dir = ""
        end

        -- Cache icon
        local ext = vim.fn.fnamemodify(file, ":e")
        local name = vim.fn.fnamemodify(file, ":t")
        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok then
            local icon, icon_hl = devicons.get_icon(name, ext, { default = true })
            cache[bufnr].icon = icon or ""
            if icon_hl then
                cache[bufnr].icon_hl = get_or_create_icon_hl(icon_hl, "StatusLine")
            else
                cache[bufnr].icon_hl = "StatusLine"
            end
        end
    end,
})

-- Global function called by Neovim to construct the statusline string
function _G.RenderStatusLine()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_cache = cache[bufnr] or { size = "", icon = "", icon_hl = "StatusLine", dir = "", tail = "" }

    -- =============
    -- LEFT ANCHORED
    -- =============

    -- Autoformat status
    local is_autoformat_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    local autoformat = string.format(
        "%%#%s# %s %%#StatusLine#",
        is_autoformat_disabled and "SlAutoformatDisabled" or "SlAutoformatEnabled",
        is_autoformat_disabled and globals.autoformat_off_symbol or globals.autoformat_on_symbol
    )

    -- Git branch
    local git_head = vim.b.gitsigns_head
    local branch = git_head and string.format("%%#SlGitBranch#  %s %%#StatusLine#", git_head) or ""

    -- Git diff
    local git_dict = vim.b.gitsigns_status_dict or {}
    local diff_parts = {}
    if (git_dict.added or 0) > 0 then
        table.insert(diff_parts, "%#SlGitDiffAdded#+" .. git_dict.added)
    end
    if (git_dict.changed or 0) > 0 then
        table.insert(diff_parts, "%#SlGitDiffChanged#~" .. git_dict.changed)
    end
    if (git_dict.removed or 0) > 0 then
        table.insert(diff_parts, "%#SlGitDiffRemoved#-" .. git_dict.removed)
    end
    local diff = #diff_parts > 0 and string.format(" %s %%#StatusLine#", table.concat(diff_parts, " ")) or ""

    -- Diagnostics
    local diags = vim.diagnostic.count(bufnr)
    local errs = (diags[1] and diags[1] > 0) and string.format("%%#SlError# %s:%d ", globals.error_symbol, diags[1])
        or ""
    local warns = (diags[2] and diags[2] > 0) and string.format("%%#SlWarn# %s:%d ", globals.warning_symbol, diags[2])
        or ""
    local infos = (diags[3] and diags[3] > 0) and string.format("%%#SlInfo# %s:%d ", globals.info_symbol, diags[3])
        or ""
    local hints = (diags[4] and diags[4] > 0) and string.format("%%#SlHint# %s:%d ", globals.hint_symbol, diags[4])
        or ""
    local diagnostics = string.format("%s%s%s%s%%#StatusLine#", errs, warns, infos, hints)

    local left = string.format("%s%s%s%s", autoformat, branch, diff, diagnostics)

    -- =======
    -- CENTRED
    -- =======

    -- Display LSP info or path
    local lsp_status = vim.lsp.status()
    local dir_path = ""
    local tail_path = ""
    local lsp_progress = ""
    local icon = ""
    if lsp_status ~= "" then
        lsp_progress = string.format("%%#SlPathDim# 󱅝 %s %%#StatusLine#", lsp_status)
    else
        dir_path = (buf_cache.dir ~= "") and string.format("%%#SlPathDim#%s", buf_cache.dir) or ""
        tail_path = (buf_cache.tail ~= "") and string.format("%%#SlPathBright#%s", buf_cache.tail) or ""
        if dir_path ~= "" or tail_path ~= "" then
            icon = buf_cache.icon ~= "" and string.format(" %%#%s#%s%%#StatusLine#", buf_cache.icon_hl, buf_cache.icon)
                or ""
        end
    end

    -- Truncated if necessary
    local centre = string.format("%%< %s%s%s%s", dir_path, lsp_progress, tail_path, icon)

    -- ==============
    -- RIGHT ANCHORED
    -- ==============

    -- -- File size
    -- local size = (buf_cache.size ~= "") and string.format("%%#SlSize# %s %%#StatusLine#", buf_cache.size) or ""

    local right = string.format("%%#SlLocation# %%3l:%%-2c %%#StatusLine#%%#SlProgress# %%3p%%%% %%#StatusLine#")

    -- ================
    -- BUILD FINAL LINE
    -- ================
    return string.format("%s%%=%s%%=%s", left, centre, right)
end

-- Set the status line universally
-- luacheck: ignore 122
vim.opt.statusline = "%!v:lua.RenderStatusLine()"

-- Update statusline when autoformatting gets toggled
vim.api.nvim_create_autocmd("User", {
    desc = "Update statusline on autoformatting toggle",
    pattern = "FormatToggle",
    group = vim.api.nvim_create_augroup("StatusLineUpdate", { clear = true }),
    callback = function()
        vim.cmd.redrawstatus()
    end,
})

-- Update statusline when LSP servers send progress updates
vim.api.nvim_create_autocmd("LspProgress", {
    desc = "Update statusline on LSP progress",
    group = vim.api.nvim_create_augroup("StatusLineLsp", { clear = true }),
    callback = function()
        vim.cmd.redrawstatus()
    end,
})

return M
