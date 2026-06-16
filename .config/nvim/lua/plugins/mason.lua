local globals = require("config.globals")
local safe_require = require("config.utils").safe_require

vim.schedule(function()
    vim.pack.add({
        "https://github.com/mason-org/mason.nvim",
        "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    })

    safe_require("mason").setup({})

    -- Get list of things for Mason to install
    local unique_tools = {}
    -- Add LSPs
    for _, tool in ipairs(globals.lsps) do
        unique_tools[tool] = true
    end
    -- Add linters
    for _, tool_list in pairs(globals.linters) do
        for _, tool in ipairs(tool_list) do
            if type(tool) == "string" then
                unique_tools[tool] = true
            end
        end
    end
    -- Add formatters
    for _, tool_list in pairs(globals.formatters) do
        for _, tool in ipairs(tool_list) do
            if type(tool) == "string" then
                -- Skip any formatter mapped to false
                local mapped_value = globals.conform_to_mason[tool]
                if mapped_value ~= false then
                    local mason_name = mapped_value or tool
                    unique_tools[mason_name] = true
                end
            end
        end
    end
    local ensure_mason_installed = vim.tbl_keys(unique_tools)

    -- Ensure Mason has everything installed
    local mti = safe_require("mason-tool-installer")
    if mti then
        mti.setup({
            ensure_installed = ensure_mason_installed,
            auto_update = true,
            -- Will be executed manually once Mason is done loading
            run_on_start = false,
        })

        -- Manually trigger check/install process now that Mason is
        -- loaded
        --
        -- 'false' = only install missing tools instead of
        -- force-updating everything
        mti.check_install(false)
    end
end)
