return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local globals = require("config.globals")
        local lsp_servers = require("config.lsp_servers")

        -- Load LSP servers
        for server_name, custom_config in pairs(lsp_servers) do
            vim.lsp.config(server_name, custom_config)
        end
        -- Globally enable and spin up all configured envs
        vim.lsp.enable(vim.tbl_keys(lsp_servers))

        -- Diagnostic UI config
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            update_in_insert = false, -- Update upon leaving insert
            underline = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = globals.error_symbol,
                    [vim.diagnostic.severity.WARN] = globals.warning_symbol,
                    [vim.diagnostic.severity.HINT] = globals.hint_symbol,
                    [vim.diagnostic.severity.INFO] = globals.info_symbol,
                }
            },
            float = {
                source = true,
                header = "",
            }
        })

        -- Things to do when a particular LSP attaches
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("user_lsp_config", { clear = true }),
            callback = function(ev)
                -- Load keymaps
                require("config.plugin_keymaps").set_lsp_keymaps(ev.buf)

                -- Retrieve the client that just got attached and
                -- ensure it exists
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then return end
                -- Enable document highlighting if LSP supports it
                if client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

                    vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = highlight_augroup })

                    -- Highlight if user pauses in normal or insert mode
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = ev.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    -- Clear highlights after user moves cursor
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = ev.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end
        })
    end,
}
