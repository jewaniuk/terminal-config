return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" }, -- Load the plugin right before saving a buffer
        opts = {
            -- Define formatters per filetype
            formatters_by_ft = {
                -- Run isort first, then black sequentially
                python = { "isort", "black" },
                -- Uses standard rustfmt (matches `cargo fmt`)
                rust = { "rustfmt" },
            },

            -- Enable format on save
            format_on_save = {
                timeout_ms = 500,        -- Don't freeze Neovim if a formatter takes too long
                lsp_format = "fallback", -- Fall back to LSP formatting if external tools aren't found
            },
        },
        keys = {
            -- Optional manual format shortcut
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                desc = "Format buffer manually",
            },
        },
    }
}
