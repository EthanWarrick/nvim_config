---@type LazyPluginSpec
local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.version = false -- last release is way too old and doesn't work on Windows

Plugin.build = ":TSUpdate"

Plugin.dependencies = {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}

Plugin.event = { "VeryLazy" }

Plugin.lazy = vim.fn.argc(-1) == 0 -- load treesitter early when opening a file from the cmdline

Plugin.init = function(plugin)
  -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
  -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
  -- no longer trigger the **nvim-treesitter** module to be loaded in time.
  -- Luckily, the only things that those plugins need are the custom queries, which we make available
  -- during startup.
  require("lazy.core.loader").add_to_rtp(plugin)
  require("nvim-treesitter.query_predicates")
end

Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }
-- Plugin.keys = {
--   { "<c-space>", desc = "Increment Selection" },
--   { "<bs>", desc = "Decrement Selection", mode = "x" },
-- }

---@type TSConfig
---@diagnostic disable-next-line: missing-fields
Plugin.opts = {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {
    "bash",
    "diff",
    "query",
    "regex",
    "vim",
    "vimdoc",
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<C-space>",
  --     node_incremental = "<C-space>",
  --     scope_incremental = false,
  --     node_decremental = "<bs>",
  --   },
  -- },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
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

Plugin.opts_extend = { "ensure_installed" } -- Secret Lazy.nvim spec

---@param opts TSConfig
Plugin.config = function(_, opts)
  if type(opts.ensure_installed) == "table" then
    ---@type table<string, boolean>
    local added = {}
    opts.ensure_installed = vim.tbl_filter(function(lang)
      if added[lang] then
        return false
      end
      added[lang] = true
      return true
    end, opts.ensure_installed)
  end
  require("nvim-treesitter.configs").setup(opts)
  vim.schedule(function()
    require("lazy").load({ plugins = { "nvim-treesitter-textobjects" } })
  end)
end

return Plugin
