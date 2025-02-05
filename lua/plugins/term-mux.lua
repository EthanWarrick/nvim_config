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
  "TmuxNavigatorProcessList",
}

Tmux.keys = {
  { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "x" }, desc = "Tmux navigate left" },
  { "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "x" }, desc = "Tmux navigate down" },
  { "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "x" }, desc = "Tmux navigate up" },
  { "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "x" }, desc = "Tmux navigate right" },
  { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "x" }, desc = "Tmux navigate previous" },
}

---@type LazyPluginSpec
local Zellij = { "swaits/zellij-nav.nvim" }
-- Pair with https://github.com/hiasr/vim-zellij-navigator

-- Enbale Zellij navigator plugin only if nvim is opened from within Zellij
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
