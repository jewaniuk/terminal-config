local opt = vim.opt

-- UI & Display
opt.number = true             -- show the current line number
opt.relativenumber = true     -- show relative numbers (makes jumping easier)
opt.signcolumn = "yes"        -- keep the left margin open so text doesn't shift
opt.termguicolors = true      -- enable rich colors that match the terminal theme

-- Tabs & Indentation
opt.tabstop = 4               -- a tab counts as 4 spaces
opt.shiftwidth = 4            -- shift 4 spaces when using >> or <<
opt.expandtab = true          -- convert tabs to spaces automatically

-- Search & Clipboard
opt.ignorecase = true         -- case-insenstive search
opt.smartcase = true          -- switch to case-sensitive if you type a capital letter
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- Native Neovim Settings
-- start the built-in treesitter engine
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
