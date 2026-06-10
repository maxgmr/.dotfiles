return {
    error_symbol = "󰚌",
    warning_symbol = "󰩏",
    hint_symbol = "󰌵",
    info_symbol = "",

    undodir = "~/.vim/undodir",
    plugins_dir = "plugins",
    lsps_dir = "lsps",
    formatters_dir = "formatters",

    default_keymap_opts = { noremap = true, silent = true },

    -- Plugins which should be loaded before all others, and the order
    -- in which they should be loaded
    high_priority_plugins = {
        "gruvbox",
        "mason",
    },

    -- This list should contain values from the nvim-lspconfig list:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    --
    -- Individual LSPs can be configured by creating a file at
    -- `lua/lsps/<LSP>.lua` with the following format:
    -- ```
    -- ---@type vim.lsp.Config
    -- local config = {
    --     [...]
    -- }
    -- vim.lsp.config("<LSP>", config)
    -- ```
    lsps = {
        "asm_lsp",
        "awk_ls",
        "bashls",
        "clangd",
        "cmake",
        "csharp_ls",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "lemminx",
        "lua_ls",
        "markdown_oxide",
        "pyright",
        "rust_analyzer",
        "somesass_ls",
        "sqlls",
        "taplo",
        "ts_ls",
        "yamlls",
    },

    linters = {},

    -- This list should follow the formatters_by_ft layout detailed on
    -- the conform.nvim GitHub:
    -- https://github.com/stevearc/conform.nvim#options
    --
    -- Individual formatters can be configured by creating a file at
    -- `lua/formatters/<FORMATTER>.lua` with the following format:
    -- ```
    -- require("conform").formatters.<FORMATTER> = {
    --     [...]
    -- }
    -- ```
    formatters = {
        asm = { "asmfmt" },
        bash = { "shfmt" },
        c = { "clang_format" },
        cmake = { "cmake_format" },
        cpp = { "clang_format" },
        cs = { "csharpier" },
        css = { "prettierd" },
        go = { "gofumpt" },
        html = { "prettierd" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        toml = { "taplo" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml = { "yamlfmt" },
    },

    -- Translation table if the Mason name differs from the conform name
    -- Map to false if there is no Mason name
    -- Mason name list: https://mason-registry.dev/registry/list
    conform_to_mason = {
        clang_format = "clang-format",
        cmake_format = "cmakelang",
        ruff_format = "ruff",
        rustfmt = false,
    },
}
