if vim.fn.expand("%:t") == "Cargo.toml" then
    require("crates").setup()
end
