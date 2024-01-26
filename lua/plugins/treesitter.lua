local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}

Plugin.event = "VeryLazy"
Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

Plugin.build = ":TSUpdate"

Plugin.init = function(plugin)
  -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
  -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
  -- no longer trigger the **nvim-treeitter** module to be loaded in time.
  -- Luckily, the only thins that those plugins need are the custom queries, which we make available
  -- during startup.
  require("lazy.core.loader").add_to_rtp(plugin)
  require("nvim-treesitter.query_predicates")
end

-- See :help nvim-treesitter-modules
Plugin.opts = {
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}

require("util").ts_ensure_installed({
  "vim",
  "vimdoc",
})

function Plugin.config(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return Plugin
