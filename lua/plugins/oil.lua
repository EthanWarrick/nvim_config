local Plugin = { "stevearc/oil.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
  { "SirZenith/oil-vcs-status", opts = { status_symbol = require("util").icons.git } },
}

-- This isn't lazy loading correctly because its not loading on ':edit .' unless
--  already loaded.
Plugin.lazy = false

Plugin.cmd = { "Oil" }

Plugin.keys = {
  {
    "<leader>fe",
    function()
      require("oil").open_float()
    end,
    mode = "n",
    desc = "Open oil file explorer",
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
    signcolumn = "yes",
  },
  keymaps = {
    ["<Esc>"] = { callback = "actions.close", mode = "n", desc = "Close oil window" },
  },
  view_options = {
    show_hidden = true,
  },
}

Plugin.init = function()
  -- Disable the default netrw file explorer
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

return Plugin
