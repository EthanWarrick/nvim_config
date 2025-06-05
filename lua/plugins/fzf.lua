---@type LazyPluginSpec
local Plugin = { "ibhagwan/fzf-lua" }

Plugin.cmd = {
  "FzfLua",
  "FZF",
}

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

Plugin.keys = {
  -- Buffers and Files --
  {
    "<leader>bb",
    function()
      require("fzf-lua").buffers()
    end,
    mode = "n",
    desc = "Find buffers",
  },
  {
    "<leader>ff",
    function()
      require("fzf-lua").files()
    end,
    mode = "n",
    desc = "Find files",
  },
  -- Search --
  {
    "gs",
    require("util").grep_operator(function(query)
      require("fzf-lua").grep({ search = query })
    end),
    mode = { "n", "x" },
    desc = "Grep operator",
  },
  {
    "<leader>fg",
    function()
      require("fzf-lua").live_grep_glob()
    end,
    mode = "n",
    desc = "Live grep",
  },
  {
    "<leader>fs",
    function()
      require("fzf-lua").lgrep_curbuf()
    end,
    mode = "n",
    desc = "Current buffer fuzzy find",
  },
  -- Git --
  {
    "<leader>gC",
    function()
      require("fzf-lua").git_commits()
    end,
    mode = "n",
    desc = "Find project git commits",
  },
  {
    "<leader>gc",
    function()
      require("fzf-lua").git_bcommits()
    end,
    mode = "n",
    desc = "Find file git commits",
  },
  {
    "<leader>gb",
    function()
      require("fzf-lua").git_branches()
    end,
    mode = "n",
    desc = "Find git branches",
  },
  -- LSP/Diagnostics --
  {
    "<leader>fd",
    function()
      require("fzf-lua").diagnostics_document()
    end,
    mode = "n",
    desc = "List document diagnostics",
  },
  -- Misc --
  {
    "<leader>c",
    function()
      require("fzf-lua").colorschemes()
    end,
    mode = "n",
    desc = "View colorschemes",
  },
  {
    "<leader>fc",
    function()
      require("fzf-lua").command_history()
    end,
    mode = "n",
    desc = "View command history",
  },
  {
    "<leader>fm",
    function()
      require("fzf-lua").marks()
    end,
    mode = "n",
    desc = "View marks",
  },
  {
    "<leader>fr",
    function()
      require("fzf-lua").registers()
    end,
    mode = "n",
    desc = "View registers",
  },
  {
    "<leader>k",
    function()
      require("fzf-lua").keymaps()
    end,
    mode = "n",
    desc = "View keymaps",
  },
}

Plugin.opts = function()
  local actions = require("fzf-lua.actions")
  return {
    winopts = {
      on_create = function()
        local b = vim.api.nvim_get_current_buf()

        -- Access vim registers from FZF prompt
        vim.keymap.set("t", "<C-r>", function()
          vim.schedule(function()
            local char = vim.fn.getchar()
            local key = vim.fn.nr2char(char)
            vim.fn.feedkeys(vim.fn.getreg(key))
          end)
        end, { buffer = b, expr = true })
      end,
    },
  }
end

Plugin.config = function(_, opts)
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup(opts)
  fzf_lua.register_ui_select()
end

return Plugin
