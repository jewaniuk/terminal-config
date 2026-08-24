return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", "rust_analyzer", "clangd",
                    "arduino_language_server", "zls", "ols",
                    "lua_ls", "marksman",
                }
            })

            -- Cross-platform Arduino CLI path resolution
            local sysname = vim.loop.os_uname().sysname
            local arduino_yaml = "~/.arduino15/arduino-cli.yaml" -- Default/Linux
            if sysname == "Darwin" then
                arduino_yaml = "~/Library/Arduino15/arduino-cli.yaml"
            elseif sysname == "Windows_NT" then
                arduino_yaml = "~/AppData/Local/Arduino15/arduino-cli.yaml"
            end

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config.arduino_language_server = {
                cmd = {
                    "arduino-language-server",
                    "-cli-config", vim.fn.expand(arduino_yaml),
                    "-cli", "arduino-cli",
                    "-clangd", "clangd"
                },
                capabilities = capabilities,
            }

            local servers = {
                "rust_analyzer", "clangd",
                "arduino_language_server", "zls", "ols",
                "lua_ls", "marksman",
            }

            for _, lsp in ipairs(servers) do
                vim.lsp.enable(lsp)
            end

            require("lspconfig").pyright.setup({
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            diagnosticSeverityOverrides = {
                                reportUnusedImport = "warning",
                                reportUnusedVariable = "warning",
                            }
                        }
                    }
                }
            })

            -- LSP Keymaps
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'hover documentation' })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'go to definition' })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'rename symbol' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'see code action' })
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'show diagnostic' })
        end
    }
}
