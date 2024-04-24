local Plugin = { "ibhagwan/fzf-lua" }

-- Plugin.enabled = false

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
  { "junegunn/fzf", build = "./install --bin" }, -- Installs fzf utility
  {
    "roginfarrer/fzf-lua-lazy.nvim",
    keys = {
      {
        "<leader>v",
        function()
          require("fzf-lua-lazy").search()
        end,
        mode = "n",
        desc = "Find in lazy.nvim spec",
      },
    },
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
        fzf.live_grep()
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

Plugin.config = function()
  local actions = require("fzf-lua.actions")
  require("fzf-lua").setup({
    actions = {
      files = {
        ["default"] = actions.file_edit,
        ["ctrl-s"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"] = actions.file_sel_to_qf,
        ["alt-l"] = actions.file_sel_to_ll,
      },
    },
  })
end

return Plugin
