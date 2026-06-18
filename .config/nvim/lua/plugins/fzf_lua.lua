local globals = require("config.globals")
local safe_require = require("config.utils").safe_require
local M = {}

vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
})
local fzf = safe_require("fzf-lua")
if not fzf then
    return M
end

fzf.setup({})

-- Export unicode picker
function M.unicode_picker()
    local cmd = [[python3 -c "
import unicodedata
for i in range(32, 0x110000):
    try:
        c = chr(i)
        name = unicodedata.name(c)
        if c.isprintable():
            print(f'{c}  {name.lower()}')
    except ValueError:
        continue
"]]

    fzf.fzf_exec(cmd, {
        cmd = cmd,
        actions = {
            ["default"] = function(selected)
                if not selected or #selected == 0 then
                    return
                end
                local char = vim.fn.strcharpart(selected[1], 0, 1)
                vim.api.nvim_put({ char }, "c", false, true)
            end,
        },
        winopts = {
            title = " System Unicode Database ",
            height = globals.unicode_height_percent,
            width = globals.unicode_width_percent,
        },
    })
end
return M
