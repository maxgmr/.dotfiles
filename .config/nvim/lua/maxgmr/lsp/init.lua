local status_ok, _ = pcall(require, "vim.lsp.config")
if not status_ok then
	vim.notify("ERROR: Failed to load lspconfig.")
	return
end

require("maxgmr.lsp.mason")
require("maxgmr.lsp.handlers").setup()
