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

-- Buffer Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>') -- Write
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>') -- Quit
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>') -- Buffer quit
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>') -- Buffer last
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>') -- Buffer next
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>') -- Buffer previous

-- Copy path
vim.keymap.set('n', '<leader>p', ':let @" = expand("%")<cr>') -- Copy relative path
vim.keymap.set('n', '<leader>P', ':let @" = expand("%:p")<cr>') -- Copy absolute path

-- Insert Newline
-- vim.keymap.set('n', '<leader>o', ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>') -- Insert newline below
-- vim.keymap.set('n', '<leader>O', ':<C-u>call append(line(".")-1,   repeat([""], v:count1))<CR>') -- Insert newline below
vim.keymap.set('n', '<leader>o', 'o<Esc>') -- Insert newline below
vim.keymap.set('n', '<leader>O', 'O<Esc>') -- Insert newline below
