return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        ft = { "markdown" },
        opts = {
            heading = {
                sign = false,
                icons = {},       -- Removes the heading icons entirely
                backgrounds = {}, -- Removes the ugly background color blocks
            },
            checkbox = {
                unchecked = { icon = '□ ' }, -- High-contrast unfilled box
                checked = { icon = '■ ' },   -- High-contrast filled box
            },
        },
        keys = {
            { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown rendering" },
        },
    }
}
