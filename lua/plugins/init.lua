local Plugins = {
  {'tpope/vim-fugitive'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},
  {'numToStr/Comment.nvim', config = true, event = 'VeryLazy'},
	{'christoomey/vim-tmux-navigator'},
  {"mertzt89/grep-op.nvim", config = true, lazy = false},

  {import = ... .. '.lang'},
}

return Plugins
