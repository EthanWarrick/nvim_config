local Plugin = {'kdheepak/lazygit.nvim'}

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim'},
}

Plugin.cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}
Plugin.keys = {
  {'<leader>g', '<cmd>LazyGit<cr>', mode = 'n', desc = 'Open Lazygit Window'},
  {'<leader>G', '<cmd>LazyGitFilter<cr>', mode = 'n', desc = 'Open Lazygit Commits Window'},
}

function Plugin.init()
  vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
  vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available

end

return Plugin
