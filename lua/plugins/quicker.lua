local Plugin = { "stevearc/quicker.nvim" }

Plugin.ft = "qf"

Plugin.keys = {
  {
    "<leader>q",
    function()
      require("quicker").toggle()
    end,
    mode = "n",
    desc = "Toggle quickfix",
  },
  {
    "<leader>l",
    function()
      require("quicker").toggle({ loclist = true })
    end,
    mode = "n",
    desc = "Toggle loclist",
  },
}

---@module "quicker"
---@type quicker.SetupOptions
Plugin.opts = {
  keys = {
    {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
}

return Plugin
