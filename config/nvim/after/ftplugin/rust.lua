-- Disable auto-continuation of "//" comments on <Enter>/o/O
-- Disable auto-wrapping of comment text while typing
vim.opt_local.formatoptions:remove({ "r", "o", "c" })
