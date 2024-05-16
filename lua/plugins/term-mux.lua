---@type LazyPluginSpec
local Tmux = { "christoomey/vim-tmux-navigator" }

-- Enbale Tmux navigator plugin only if nvim is opened from within Tmux
Tmux.cond = os.getenv("TMUX") ~= nil

Tmux.cmd = {
  "TmuxNavigateLeft",
  "TmuxNavigateDown",
  "TmuxNavigateUp",
  "TmuxNavigateRight",
  "TmuxNavigatePrevious",
}

Tmux.keys = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Tmux navigate left" } },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Tmux navigate down" } },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Tmux navigate up" } },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Tmux navigate right" } },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { desc = "Tmux navigate previous" } },
}

---@type LazyPluginSpec
local Zellij = { "swaits/zellij-nav.nvim" }

-- Enbale Tmux navigator plugin only if nvim is opened from within Tmux
Zellij.cond = os.getenv("ZELLIJ") ~= nil

Zellij.config = true

Zellij.cmd = {
  "ZellijNavigateLeft",
  "ZellijNavigateDown",
  "ZellijNavigateUp",
  "ZellijNavigateRight",
}

Zellij.keys = {
  { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
  { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
  { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
  { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
}

return { Tmux, Zellij }
