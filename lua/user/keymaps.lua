-- Space as leader key
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^") -- Move cursor to line start
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "g_") -- Move cursor to line end
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Essentially creates a line text object
--  - this is for operating on lines without counting the newline
vim.keymap.set({ "x", "o" }, "al", ":normal 0vg_<CR>")
vim.keymap.set({ "x", "o" }, "il", ":normal ^vg_<CR>")

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y') -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p') -- paste

-- Delete text
vim.keymap.set({ "n", "x" }, "x", '"_x')

-- Buffer Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>") -- Write
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>") -- Quit
vim.keymap.set("n", "<leader>Q", "<cmd>quitall<cr>") -- Quit
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<cr>") -- Buffer quit
vim.keymap.set("n", "<leader>bl", "<cmd>buffer #<cr>") -- Buffer last
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>") -- Buffer next
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>") -- Buffer previous

-- Copy path
vim.keymap.set("n", "<leader>p", ':let @" = expand("%")<cr>') -- Copy relative path
vim.keymap.set("n", "<leader>P", ':let @" = expand("%:p")<cr>') -- Copy absolute path
vim.keymap.set("n", "<C-p>", ":let @+ = @%<cr>") -- Copy relative path to system clipboard

-- Insert Newline
vim.keymap.set("n", "<leader>o", "o<Esc>k") -- Insert newline below
vim.keymap.set("n", "<leader>O", "O<Esc>j") -- Insert newline above

-- Indentation shortcuts
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("x", "<Tab>", ">gv")
vim.keymap.set("x", "<S-Tab>", "<gv")

-- Toggle diagnostic messages
vim.keymap.set("n", "<leader>d", function()
  if vim.diagnostic.is_disabled(0) then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end)

-- Use escape to close all floating windows
vim.keymap.set("n", "<esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
    end
  end
end)
