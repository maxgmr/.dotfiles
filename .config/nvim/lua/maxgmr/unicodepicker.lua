local status_ok, unicode_picker = pcall(require, "unicode_picker")
if not status_ok then
	vim.notify("ERROR: Failed to load Unicode picker.")
	return
end
unicode_picker.setup()
