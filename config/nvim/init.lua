-- Set leader key first
vim.g.mapleader = " "

-- Load core settings
require("core.options")
require("core.keymaps")

-- Load your custom theme
require("themes.ghostty_horizon").setup()

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Automatically load all plugins from the `lua/plugins/` directory
require("lazy").setup("plugins")
