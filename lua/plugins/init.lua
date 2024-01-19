local Plugins = {
  { "tpope/vim-fugitive" },
  { "wellle/targets.vim" },
  { "tpope/vim-repeat" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "christoomey/vim-tmux-navigator" },

  { import = ... .. ".lang" },
}

return Plugins
