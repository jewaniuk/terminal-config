local map = vim.keymap.set

-- Window Navigation
map('n', '<C-h>', '<C-w>h', { desc = 'jump to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'jump to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'jump to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'jump to right window' })

-- --- Visual Block Indentation (Tab / Shift+Tab) ---
-- The 'gv' at the end keeps the visual selection active so you can tab repeatedly
map('v', '<Tab>', '>gv', { desc = 'Indent selected block' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent selected block' })

-- --- Toggle Comments (Cmd+/ or Ctrl+/) ---
-- Uses Neovim's built-in comment engine (gcc for normal mode, gc for visual mode)
local comment_keys = { "<D-/>", "<C-/>", "<C-_>" }

for _, key in ipairs(comment_keys) do
    map('n', key, 'gcc', { remap = true, desc = 'Toggle comment line' })
    map('v', key, 'gc', { remap = true, desc = 'Toggle comment selection' })
end

-- Paste from system clipboard on a new line below, preserving indent
map('n', '<leader>p', 'o<C-r>+<Esc>', { desc = 'Paste below from clipboard' })

-- Add empty lines above/below (cursor moves to the new line)
map('n', '<leader>o', 'o<Esc>', { desc = 'Add blank line below' })
map('n', '<leader>O', 'O<Esc>', { desc = 'Add blank line above' })
