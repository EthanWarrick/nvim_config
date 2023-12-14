local Plugin = {'kdheepak/lazygit.nvim'}

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim'},
}

Plugin.cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}

function Plugin.init()
  vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
  vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available

  vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>') -- Open Lazygit window
  vim.keymap.set('n', '<leader>G', '<cmd>LazyGitFilter<cr>') -- Open Lazygit commits window
end

return Plugin
