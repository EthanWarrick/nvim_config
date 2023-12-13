local Plugin = {'akinsho/bufferline.nvim'}

Plugin.dependencies =  {
  {'nvim-tree/nvim-web-devicons', lazy = true},
}

Plugin.name = 'bufferline'

Plugin.event = 'VeryLazy'

Plugin.opts = {
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
    separator_style = "slant",
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
}

return Plugin
