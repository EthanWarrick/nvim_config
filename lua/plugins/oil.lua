---@type LazyPluginSpec
local Plugin = { "stevearc/oil.nvim" }

Plugin.dependencies = {
  { "nvim-tree/nvim-web-devicons" },
}

Plugin.lazy = true

Plugin.cmd = { "Oil", "Explore", "E", "Hexplore", "He", "Vexplore", "Ve", "Sexplore", "Se", "Texplore", "Te" }

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
    local stat = vim.loop.fs_stat(argv)

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
  local oil = require("oil")
  oil.setup(opts)

  vim.api.nvim_create_user_command("Explore", function()
    oil.open()
  end, { desc = "Explore directory of current file" })
  vim.api.nvim_create_user_command("E", "Explore", { desc = "Shortcut for :Explore" })

  vim.api.nvim_create_user_command("Hexplore", function(args)
    if args.bang then
      vim.api.nvim_command("aboveleft Oil")
    else
      vim.api.nvim_command("belowright Oil")
    end
  end, { bang = true, desc = "Horizontal Split & Explore" })
  vim.api.nvim_create_user_command("He", function(args)
    if args.bang then
      vim.api.nvim_command("Hexplore!")
    else
      vim.api.nvim_command("Hexplore")
    end
  end, { bang = true, desc = "Shortcut for :Hexplore" })

  vim.api.nvim_create_user_command("Vexplore", function(args)
    if args.bang then
      vim.api.nvim_command("rightbelow vertical Oil")
    else
      vim.api.nvim_command("leftabove vertical Oil")
    end
  end, { bang = true, desc = "Vertical Split & Explore" })
  vim.api.nvim_create_user_command("Ve", function(args)
    if args.bang then
      vim.api.nvim_command("Vexplore!")
    else
      vim.api.nvim_command("Vexplore")
    end
  end, { bang = true, desc = "Shortcut for :Vexplore" })

  vim.api.nvim_create_user_command("Sexplore", function(args)
    if args.bang then
      vim.api.nvim_command("vsplit +Oil")
    else
      vim.api.nvim_command("split +Oil")
    end
  end, { bang = true, desc = "Split & Explore current file's directory" })
  vim.api.nvim_create_user_command("Se", function(args)
    if args.bang then
      vim.api.nvim_command("Sexplore!")
    else
      vim.api.nvim_command("Sexplore")
    end
  end, { bang = true, desc = "Shortcut for :Sexplore" })

  vim.api.nvim_create_user_command("Texplore", "tabnew Oil", { desc = "Tab & Explore" })
  vim.api.nvim_create_user_command("Te", "Texplore", { desc = "Shortcut for :Texplore" })
end

return Plugin
