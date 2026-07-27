return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            -- Find files in the project directory
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            -- Search for text inside files (requires `ripgrep` installed on your system)
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Search Text (Grep)" },
            -- Switch between currently open buffers
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Search Open Buffers" },
        },
        opts = {},
    }
}
