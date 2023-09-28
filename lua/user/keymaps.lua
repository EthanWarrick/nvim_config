-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y') -- copy
vim.keymap.set({'n', 'x'}, 'gp', '"+p') -- paste

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>') -- Write
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>') -- Quit
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>') -- Buffer quit
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>') -- Buffer last
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>') -- Buffer last
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>') -- Buffer last
