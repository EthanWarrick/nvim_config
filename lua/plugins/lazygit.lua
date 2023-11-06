local Plugin = {'kdheepak/lazygit.nvim'}

Plugin.cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}

function Plugin.init()
  vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>') -- Open Lazygit window
  vim.keymap.set('n', '<leader>G', '<cmd>LazyGitFilter<cr>') -- Open Lazygit commits window
end

return Plugin
