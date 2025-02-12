-- options
local opts = { noremap = true, silent = true }

-- keymap shorthand
local keymap = vim.keymap.set

-- BASE VIM KEYMAPS
-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- (normal) check health
keymap("n", "<leader>ch", ":checkhealth<CR>", opts)

-- (visual) remain in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- (visual) stop yank rewrite on paste
keymap("v", "p", '"_dP', opts)

-- (normal) swap between light and dark theme
keymap("n", "<leader>sc", function()
	require("colourswap").swapLightDarkTheme()
end, opts)

-- PLUGIN KEYMAPS
-- (telescope) find files
keymap(
	"n",
	"<leader>f",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<CR>",
	opts
)
-- (telescope) live grep
keymap(
	"n",
	"<leader>lg",
	"<cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({ previewer = true }))<CR>",
	opts
)

-- (nvim-tree) open nvim-tree
keymap("n", "<leader>o", ":NvimTreeToggle<CR>", opts)

-- (lazy) update packages
keymap("n", "<leader>U", ":Lazy update<CR>", opts)
-- (lazy) open Lazy
keymap("n", "<leader>L", ":Lazy<CR>", opts)

-- (mason) open Mason
keymap("n", "<leader>M", ":Mason<CR>", opts)

-- (nvim-lspconfig) open LSP info
keymap("n", "<leader>li", ":LspInfo<CR>", opts)

-- (cokeline) cycle buffers
keymap("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", opts)
keymap("n", "<Tab>", "<Plug>(cokeline-focus-next)", opts)
-- (cokeline) jump between buffers
for i = 1, 9 do
	keymap("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), opts)
end
vim.keymap.set("n", "<leader>w", function()
	local curbuf = require("cokeline.buffers").get_current()
	if curbuf ~= nil then
		curbuf:delete()
	end
end, { desc = "close buffer" })

-- (conform) show info
keymap("n", "<leader>ci", ":ConformInfo<CR>", opts)
-- (conform) disable format on save for current buffer
keymap("n", "<leader>df", ":FormatDisable<CR>", opts)
-- (conform) disable format on save globally
keymap("n", "<leader>dF", ":FormatDisable!<CR>", opts)
-- (conform) enable format on save globally
keymap("n", "<leader>ef", ":FormatEnable<CR>", opts)

-- (unicode_picker) pick a unicode character with telescope
vim.keymap.set("i", "<C-j>", require("unicode_picker").unicode_chars, opts)

-- (cmp-im) toggle IM
vim.keymap.set("n", "<leader>zh", function()
	require("cmp_im").toggle()
end, opts)

-- (markdown-preview) open markdown
keymap("n", "<leader>md", ":MarkdownPreview<CR>", opts)
-- (markdown-preview) close markdown
keymap("n", "<leader>mD", ":MarkdownPreviewStop<CR>", opts)

-- (floaterm) open terminal
--[[ keymap("n", "<C-\\>", ":FloatermToggle --disposable<CR>", opts) ]]
