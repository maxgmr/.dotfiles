return {
    error_symbol = "󰚌",
    warning_symbol = "󰩏",
    hint_symbol = "󰌵",
    info_symbol = "",

    undodir = "~/.vim/undodir",
    plugins_dir = "plugins",
    lsps_dir = "lsps",

    default_keymap_opts = { noremap = true, silent = true },

    -- Plugins which should be loaded before all others, and the order
    -- in which they should be loaded
    high_priority_plugins = {
        "gruvbox",
        "mason",
    },

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

    linters = {
    },

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

    -- Translation table if the mason name differs from the conform name
    -- Map to false if there is no mason name
    conform_to_mason = {
        clang_format = "clang-format",
        cmake_format = "cmakelang",
        ruff_format = "ruff",
        rustfmt = false,
    }
}
