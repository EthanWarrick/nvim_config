local Plugin = { "christoomey/vim-tmux-navigator" }

-- Enbale Tmux navigator plugin only if nvim is opened from within Tmux
Plugin.cond = os.getenv("TMUX") ~= nil

Plugin.cmd = {
  "TmuxNavigateLeft",
  "TmuxNavigateDown",
  "TmuxNavigateUp",
  "TmuxNavigateRight",
  "TmuxNavigatePrevious",
}

Plugin.keys = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Tmux navigate left" } },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Tmux navigate down" } },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Tmux navigate up" } },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Tmux navigate right" } },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { desc = "Tmux navigate previous" } },
}

return Plugin
