local Plugin = {'nvim-lualine/lualine.nvim'}

Plugin.name = 'lualine'

Plugin.event = 'VeryLazy'

-- See :help lualine.txt
Plugin.opts = {
  options = {
    -- theme = 'onedark',
    theme = 'catppuccin',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
  },
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
