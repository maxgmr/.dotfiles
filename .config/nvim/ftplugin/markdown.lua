vim.cmd("runtime ftplugin/text.lua")

vim.keymap.set("n", "<leader>md", function()
    local current_file = vim.fn.expand("%:p")

    -- Guard against empty buffers
    if current_file == "" then
        vim.notify("Buffer has no file path. Save the file first.", vim.log.levels.WARN)
        return
    end

    -- Extract base file name and construct /tmp path
    local base_name = vim.fn.expand("%:t:r")
    local output_html = "/tmp/" .. base_name .. ".html"

    -- Build the shell command
    local current_file_esc = vim.fn.shellescape(current_file)
    local output_html_esc = vim.fn.shellescape(output_html)
    local cmd = string.format("pandoc %s -o %s && firefox %s", current_file_esc, output_html_esc, output_html_esc)

    vim.fn.jobstart(cmd, {
        on_exit = function(_, exit_code)
            if exit_code ~= 0 then
                vim.notify("Pandoc or xdg-open failed to execute.", vim.log.levels.ERROR)
            end
        end,
    })
end, {
    buffer = true,
    desc = "Convert Markdown to HTML via Pandoc and open preview",
})
