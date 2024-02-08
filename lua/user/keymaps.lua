-- Space as leader key
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^", { desc = "Move cursor to line start" })
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "g_", { desc = "Move cursor to line end" })
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Visual select whole buffer" })
vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = "Insert newline below" })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = "Insert newline above" })

local close_floats = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
    end
  end
end
vim.keymap.set("n", "<esc>", function()
  close_floats()
  vim.api.nvim_command("nohlsearch")
end, { desc = "Close all floating windows & disable search highlight" })

-- Essentially creates a line text object
--  - this is for operating on lines without counting the newline
vim.keymap.set({ "x", "o" }, "al", ":normal 0v$h<CR>", { desc = "'around-line' text object" })
vim.keymap.set({ "x", "o" }, "il", ":normal ^vg_<CR>", { desc = "'in-line' text object" })

-- Basic clipboard/register interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste to system clipboard" })
vim.keymap.set("n", "<C-p>", ":let @+ = @%<cr>", { desc = "Copy relative path to system clipboard" })
vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = 'Delete without saving to " register' })

-- Buffer Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<cr>", { desc = "Buffer quit" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffer #<cr>", { desc = "Buffer last" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buffer previous" })

vim.keymap.set("n", "<leader>d", function()
  if vim.diagnostic.is_disabled(0) then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end, { desc = "Toggle diagnostic messages" })
