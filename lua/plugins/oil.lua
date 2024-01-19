local Plugin = { "stevearc/oil.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
}

-- This isn't lazy loading correctly because its not loading on ':edit .' unless
--  already loaded.
Plugin.cmd = { "Oil" }

Plugin.keys = {
  {
    "<leader>fe",
    function()
      require("oil").open_float()
    end,
    mode = "n",
    desc = "Oil",
  },
}

Plugin.opts = {
  columns = {
    "icon",
    "permissions",
    "size",
  },
  win_options = {
    statuscolumn = "",
    relativenumber = false,
    colorcolumn = "",
  },
  keymaps = {
    ["<Esc>"] = { callback = "actions.close", mode = "n" },
  },
  view_options = {
    show_hidden = true,
  },
}

return Plugin
