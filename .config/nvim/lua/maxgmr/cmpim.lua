local status_ok, cmp_im = pcall(require, "cmp_im")
if not status_ok then
	vim.notify("ERROR: cmp_im loading failed.")
	return
end

local zh_status_ok, cmp_im_zh = pcall(require, "cmp_im_zh")
if not zh_status_ok then
	vim.notify("ERROR: cmp_im_zh loading failed.")
	return
end

cmp_im.setup({
	enable = false,
	tables = cmp_im_zh.tables({ "pinyin" }),
	maxn = 20,
})
