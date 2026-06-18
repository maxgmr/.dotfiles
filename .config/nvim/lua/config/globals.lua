return {
    -- List of plugins in the order they should be loaded in
    --
    -- Each entry must correspond to a file name within `lua/plugins/`
    plugins = {
        -- Should be loaded first
        "gruvbox",
        "web_devicons",
        "mason",
        -- Load order irrelevant
        "blink_cmp",
        "conform",
        "crates",
        "fzf_lua",
        "gitsigns",
        "lint",
        "lspconfig",
        "mini_files",
        "mini_pairs",
        "tree_sitter_manager",
    },

    -- This list should contain values from the nvim-lspconfig list:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    lsps = {
        "asm-lsp",
        "awk-language-server",
        "bash-language-server",
        "clangd",
        "cmake-language-server",
        "csharp-language-server",
        "css-lsp",
        "docker-language-server",
        "gopls",
        "html-lsp",
        "jdtls",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "markdown-oxide",
        "pyright",
        "rust-analyzer",
        "some-sass-language-server",
        "sqlls",
        "taplo",
        "typescript-language-server",
        "yaml-language-server",
    },

    -- Individual LSPs can be configured by creating a file at
    -- `lua/lsps/<LSP>.lua` with the following format:
    -- ```
    -- ---@type vim.lsp.Config
    -- local config = {
    --     [...]
    -- }
    -- vim.lsp.config("<LSP>", config)
    -- ```
    --
    -- <LSP> should match one of the names in the nvim-lspconfig list:
    -- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
    lsp_configs = {
        "rust_analyzer",
    },

    -- This list should follow the linters_by_ft format and be from the
    -- nvim-lint list:
    -- https://github.com/mfussenegger/nvim-lint#available-linters
    linters = {
        bash = { "shellcheck" },
        css = { "stylelint" },
        dockerfile = { "hadolint" },
        go = { "golangci-lint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        lua = { "luacheck" },
        markdown = { "markdownlint", "vale" },
        python = { "ruff" },
        scss = { "stylelint" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        yaml = { "yamllint" },
    },

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
        xml = { "xmlformatter" },
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

    error_symbol = "󰚌",
    warning_symbol = "󰩏",
    hint_symbol = "󰌵",
    info_symbol = "",

    autoformat_on_symbol = "󰈈",
    autoformat_off_symbol = "",

    term_width_percent = 0.8,
    term_height_percent = 0.8,

    unicode_width_percent = 0.8,
    unicode_height_percent = 0.8,

    undodir = "~/.vim/undodir",
    formatters_dir = "formatters",

    default_keymap_opts = { noremap = true, silent = true },
}
