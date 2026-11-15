return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" }, -- Load the plugin right before saving a buffer
        opts = {
            -- Define formatters per filetype
            formatters_by_ft = {
                -- Run ruff to organize imports first, then format
                python = { "ruff_organize_imports", "ruff_format" },
                -- Uses standard rustfmt (matches `cargo fmt`)
                rust = { "rustfmt" },
                -- Uses a project-local prettier and config when present, else the Mason one
                html = { "prettier" },
                css = { "prettier" },
                typescript = { "prettier" },
                javascript = { "prettier" },
                json = { "prettier" },
                -- svelte is left out on purpose: the svelte language server formats it
                -- with its bundled prettier-plugin-svelte (via lsp_format = "fallback")
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
    },

    -- Installs formatters (not LSPs) through Mason on a fresh machine
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "prettier" },
        },
    },
}
