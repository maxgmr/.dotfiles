local safe_require = require("config.utils").safe_require

vim.pack.add({
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/L3MON4D3/LuaSnip",
})

local cmp = safe_require("blink.cmp")
if cmp then
    cmp.build():pwait()
    cmp.setup({
        keymap = {
            preset = "none",
            ["<C-Space>"] = { "show", "hide" },
            ["<Tab>"] = { "accept", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-Right>"] = { "snippet_forward", "fallback" },
            ["<C-Left>"] = { "snippet_backward", "fallback" },
        },
        appearance = { nerd_font_variant = "mono" },
        completion = { menu = { auto_show = true } },
        sources = { default = { "lsp", "path", "buffer", "snippets" } },
        snippets = {
            expand = function(snippet)
                local luasnip = safe_require("luasnip")
                if luasnip then
                    luasnip.lsp_expand(snippet)
                end
            end,
        },
        fuzzy = { implementation = "rust" },
    })
end

-- luacheck: ignore 122
vim.lsp.config["*"] = {
    capabilities = safe_require("blink.cmp").get_lsp_capabilities(),
}
