---@type LazyPluginSpec
local Plugin = { "ibhagwan/fzf-lua" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
  {
    "junegunn/fzf", -- Installs fzf utility
    build = {
      "./install --bin --no-key-bindings --no-completion --no-update-rc",
      "ln -srf ./bin/fzf " .. vim.fn.stdpath("data") .. "/bin/",
    }, -- Assumes bin directory is in PATH
  },
}

Plugin.keys = function()
  local fzf = require("fzf-lua")
  return {
    -- Buffers and Files --
    {
      "<leader>bb",
      function()
        fzf.buffers()
      end,
      mode = "n",
      desc = "Find buffers",
    },
    {
      "<leader>ff",
      function()
        fzf.files()
      end,
      mode = "n",
      desc = "Find files",
    },
    -- Search --
    {
      "gs",
      require("util").grep_operator(function(query)
        fzf.grep({ search = query })
      end),
      mode = { "n", "x" },
      desc = "Grep operator",
    },
    {
      "<leader>fg",
      function()
        fzf.live_grep_glob()
      end,
      mode = "n",
      desc = "Live grep",
    },
    {
      "<leader>fs",
      function()
        fzf.lgrep_curbuf()
      end,
      mode = "n",
      desc = "Current buffer fuzzy find",
    },
    -- Git --
    {
      "<leader>gC",
      function()
        fzf.git_commits()
      end,
      mode = "n",
      desc = "Find project git commits",
    },
    {
      "<leader>gc",
      function()
        fzf.git_bcommits()
      end,
      mode = "n",
      desc = "Find file git commits",
    },
    {
      "<leader>gb",
      function()
        fzf.git_branches()
      end,
      mode = "n",
      desc = "Find git branches",
    },
    -- LSP/Diagnostics --
    {
      "<leader>fd",
      function()
        fzf.diagnostics_document()
      end,
      mode = "n",
      desc = "List document diagnostics",
    },
    -- Misc --
    {
      "<leader>c",
      function()
        fzf.colorschemes()
      end,
      mode = "n",
      desc = "View colorschemes",
    },
    {
      "<leader>fc",
      function()
        fzf.command_history()
      end,
      mode = "n",
      desc = "View command history",
    },
    {
      "<leader>fm",
      function()
        fzf.marks()
      end,
      mode = "n",
      desc = "View marks",
    },
    {
      "<leader>fr",
      function()
        fzf.registers()
      end,
      mode = "n",
      desc = "View registers",
    },
    {
      "<leader>k",
      function()
        fzf.keymaps()
      end,
      mode = "n",
      desc = "View keymaps",
    },
  }
end

Plugin.opts = function()
  local actions = require("fzf-lua.actions")
  return {}
end

Plugin.config = function(_, opts)
  require("fzf-lua").setup(opts)
end

return Plugin
