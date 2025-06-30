---@type LazyPluginSpec
local Plugin = { "stevearc/oil.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
  {
    "SirZenith/oil-vcs-status",
    opts = function()
      local StatusType = require("oil-vcs-status.constant.status").StatusType
      local icons = require("util").icons.git

      ---@type table<string, string>
      local status_symbol = {}
      for key, item in pairs(StatusType) do
        status_symbol[item] = icons[key]
      end

      return {
        status_symbol = status_symbol,
      }
    end,
  },
}

Plugin.lazy = true

Plugin.cmd = { "Oil", "Explore", "Ex", "E", "Hexplore", "He", "Vexplore", "Ve", "Sexplore", "Se", "Texplore", "Te" }

Plugin.keys = {
  {
    "-",
    function()
      require("oil").open_float()
    end,
    mode = "n",
    desc = "Open Oil file explorer as floating window",
  },
}

---@module 'oil'
---@type oil.SetupOpts
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
  view_options = {
    show_hidden = true,
  },
  -- Override Netrw URLs
  adapter_aliases = {
    ["ssh://"] = "oil-ssh://",
    ["scp://"] = "oil-ssh://",
    ["sftp://"] = "oil-ssh://",
  },
}

Plugin.init = function(p)
  ------------------------- Enable Lazy Loading -------------------------
  if vim.fn.argc() == 1 then
    local argv = tostring(vim.fn.argv(0))
    local stat = vim.uv.fs_stat(argv)

    local remote_dir_args = vim.startswith(argv, "ssh")
      or vim.startswith(argv, "sftp")
      or vim.startswith(argv, "scp")
      or vim.startswith(argv, "oil-ssh")

    if stat and stat.type == "directory" or remote_dir_args then
      require("lazy").load({ plugins = { p.name } })
    end
  end
  if not require("lazy.core.config").plugins[p.name]._.loaded then
    vim.api.nvim_create_autocmd("BufNew", {
      callback = function()
        if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
          require("lazy").load({ plugins = { "oil.nvim" } })
          -- Once oil is loaded, we can delete this autocmd
          return true
        end
      end,
    })
  end
  -----------------------------------------------------------------------
end

Plugin.config = function(_, opts)
  require("oil").setup(opts)

  --------------------- Setup Legacy Netrw Commands ---------------------
  ---@param command string Command name to create
  ---@param win_opts {position:oil.OpenPreviewOpts, bang_position:oil.OpenPreviewOpts} Vim position args
  local oil_command = function(command, win_opts, desc)
    local cmd = function(args)
      if args.bang then
        vim.api.nvim_cmd({ cmd = "Oil", mods = win_opts[2] }, {})
      else
        vim.api.nvim_cmd({ cmd = "Oil", mods = win_opts[1] }, {})
      end
    end
    vim.api.nvim_create_user_command(command, cmd, { bang = true, desc = desc })
    vim.api.nvim_create_user_command(command:sub(1, 2), cmd, { bang = true, desc = "Shortcut for :" .. command })
  end

  oil_command("Explore", {}, "Explore directory of current file")
  vim.api.nvim_create_user_command("E", "Explore", { desc = "Shortcut for :Explore" })
  oil_command(
    "Hexplore",
    { { split = "leftabove", horizontal = true }, { split = "rightbelow", horizontal = true } },
    "Horizontal Split & Explore"
  )
  oil_command(
    "Vexplore",
    { { split = "leftabove", vertical = true }, { split = "rightbelow", vertical = true } },
    "Vertical Split & Explore"
  )
  oil_command(
    "Sexplore",
    { { split = "leftabove", horizontal = true }, { split = "leftabove", vertical = true } },
    "Split & Explore current file's directory"
  )
  vim.api.nvim_create_user_command("Texplore", "tabnew Oil", { desc = "Tab & Explore" })
  vim.api.nvim_create_user_command("Te", "tabnew Oil", { desc = "Shortcut for :Texplore" })
  -----------------------------------------------------------------------
end

return Plugin
