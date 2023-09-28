local Plugin = {'folke/which-key.nvim'}

Plugin.name = 'which-key'

Plugin.event = 'VeryLazy'

function Plugin.init()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
end

Plugin.opts = {
  options = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}

return Plugin
