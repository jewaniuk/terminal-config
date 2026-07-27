return {
    -- Auto-Closing Brackets
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

    -- Improved Diagnostics Panel
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<leader>E", "<cmd>Trouble diagnostics toggle<cr>", desc = "toggle workspace diagnostics panel" },
        },
    },

    -- Syntax Highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "python", "rust", "arduino", "c", "cpp", "lua", "vim", "vimdoc", "zig", "odin"
            })
        end
    },

    -- Python Indentation
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
    },

    -- Git Indicators
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl      = false,
                linehl     = false,
            })

            local hl = vim.api.nvim_set_hl
            hl(0, "GitSignsAdd", { fg = "#29d398" })    -- Green for added
            hl(0, "GitSignsChange", { fg = "#fab795" }) -- Orange for modified
            hl(0, "GitSignsDelete", { fg = "#e95678" }) -- Red for deleted
        end
    },
}
