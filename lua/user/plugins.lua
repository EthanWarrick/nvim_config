local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print("Installing lazy.nvim....")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require("lazy").setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.opts = {
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "default" },
  },
  ui = {
    border = "rounded",
  },
    performance = {
    rtp = {
      ---@type string[] List any plugins you want to disable here
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

}

lazy.setup({ { import = "plugins" }, { import = "plugins.lang" } })
