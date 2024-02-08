local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons", lazy = true },
}

Plugin.event = "VeryLazy"

local function modifiedSymbol()
  return {
    function()
      return vim.bo.modified and "●" or ""
    end,
    padding = 0,
    separator = "",
    color = { fg = "green" },
  }
end
local function readonlySymbol()
  return {
    function()
      return vim.bo.readonly and "" or ""
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
    theme = "auto",
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
    lualine_x = {
      {
        "%S",
        separator = "",
      },
      recordingSymbol(),
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "searchcount", "progress" },
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

function Plugin.config(_, opts)
  vim.opt.showmode = false -- Don't show current mode in command line
  vim.opt.showcmd = true -- Enable displaying keypresses % partial commands
  vim.opt.showcmdloc = "statusline" -- Showcmd info is placed on statusline at '%S'
  vim.opt.cmdheight = 0 -- Don't show commmand line
  vim.opt.laststatus = 2 -- Determines if the status line covers multiple splits

  require("lualine").setup(opts)
end

return Plugin
