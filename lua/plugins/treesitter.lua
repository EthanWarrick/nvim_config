local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}

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
  vim.cmd("TSUpdate all")
end

return Plugin
