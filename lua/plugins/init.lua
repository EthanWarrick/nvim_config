local Plugins = {
  { "tpope/vim-fugitive", cmd = "Git" },
  { "wellle/targets.vim" },
  { "tpope/vim-repeat" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "christoomey/vim-tmux-navigator", keys = { "<c-h>", "<c-j>", "<c-k>", "<c-l>" } },

  { import = ... .. ".lang" },
}

return Plugins
