local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons", lazy = true },
}

Plugin.name = "lualine"

Plugin.event = "VeryLazy"

-- See :help lualine.txt
Plugin.opts = {
  options = {
    -- theme = 'onedark',
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = "|",
    section_separators = "",
    disabled_filetypes = {
      statusline = { "NvimTree" },
    },
  },
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
  },
  inactive_sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
  },
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
