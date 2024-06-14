---@type LazyPluginSpec
local Plugin = { "kdheepak/lazygit.nvim" }

Plugin.dependencies = {
  { "nvim-lua/plenary.nvim" },
}

Plugin.cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" }
Plugin.keys = {
  { "<leader>gg", "<cmd>LazyGit<cr>", mode = "n", desc = "Open Lazygit Window" },
  -- {'<leader>G', '<cmd>LazyGitFilter<cr>', mode = 'n', desc = 'Open Lazygit Commits Window'},
}

function Plugin.config()
  vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
  vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available

  if vim.fn.filereadable(os.getenv("HOME") .. "/.config/lazygit/private-config.yml") == 1 then
    vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
    vim.g.lazygit_config_file_path = { -- list of custom config file paths
      os.getenv("HOME") .. "/.config/lazygit/config.yml",
      os.getenv("HOME") .. "/.config/lazygit/private-config.yml",
      -- vim.fn.stdpath('config') .. '/lazygit.yml',
    }
  end
end

return Plugin
