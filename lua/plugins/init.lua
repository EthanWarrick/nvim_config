local Plugins = {
  {'tpope/vim-fugitive'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},
  {'kyazdani42/nvim-web-devicons', lazy = true},
  {'numToStr/Comment.nvim', config = true, event = 'VeryLazy'},
	{'christoomey/vim-tmux-navigator'},
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Themes
  {'joshdick/onedark.vim'},
}

return Plugins
