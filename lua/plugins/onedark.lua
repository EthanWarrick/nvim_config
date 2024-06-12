---@type LazyPluginSpec
local Plugin = { "navarasu/onedark.nvim" }

Plugin.priority = 1000

Plugin.lazy = false

Plugin.opts = {
  -- Main options --
  style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_key = nil, -- Set in Plugin.config
  toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "none",
    strings = "none",
    variables = "none",
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {
    bg0 = "#000000",
    bg1 = "#111111",
  }, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}

Plugin.config = function(_, opts)
  local onedark = require("onedark")
  onedark.setup(opts)
  vim.keymap.set("n", "<leader>C", function()
    onedark.toggle()
  end, { noremap = true, silent = true, desc = "Toggle Onedark Themes" })
  -- onedark.load() -- load the colorscheme here
end

return Plugin
