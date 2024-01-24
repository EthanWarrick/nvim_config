local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons", lazy = true },
}

Plugin.name = "lualine"

Plugin.event = "VeryLazy"

local function modifiedSymbol()
  return {
    function()
      local symbol = ""
      if vim.bo.modified then
        symbol = "●"
      end
      return symbol
    end,
    padding = 0,
    separator = "",
    color = { fg = "green" },
  }
end
local function readonlySymbol()
  return {
    function()
      local symbol = ""
      if vim.bo.readonly then
        symbol = ""
      end
      return symbol
    end,
    padding = 0,
    separator = "",
  }
end

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
        symbols = {
          modified = "",
          readonly = "",
        },
        separator = "",
        padding = { left = 1, right = 0 },
      },
      modifiedSymbol(),
      readonlySymbol(),
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
