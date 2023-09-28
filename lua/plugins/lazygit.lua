local Plugin = {'kdheepak/lazygit.nvim'}

Plugin.cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}

function Plugin.init()
  vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>')
end

return Plugin
