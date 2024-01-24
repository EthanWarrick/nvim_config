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
local function recordingSymbol()
  return {
    function()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end -- not recording
      return "Recording @" .. reg
    end,
    padding = 0,
    separator = "",
    color = { fg = "#f9905f" },
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
    lualine_x = { recordingSymbol(), "encoding", "fileformat", "filetype" },
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
  vim.opt.showmode = false -- Don't show current mode in command line
  vim.opt.cmdheight = 0 -- Don't show commmand line
  vim.opt.laststatus = 2 -- Determines if the status line covers multiple splits
end

return Plugin
