local Plugin = {'ibhagwan/fzf-lua'}

-- Plugin.enabled = false

Plugin.dependencies = {
  {'nvim-tree/nvim-web-devicons'},
  {"junegunn/fzf", build = "./install --bin"}, -- Installs fzf utility
}

Plugin.cmd = {'FzfLua',}
Plugin.keys = {
  {'<leader>fb', function() require('fzf-lua').buffers() end,              mode = 'n', desc = 'buffers'},
  {'<leader>fr', function() require('fzf-lua').registers() end,            mode = 'n', desc = 'View registers'},
  {'<leader>fm', function() require('fzf-lua').marks() end,                mode = 'n', desc = 'View marks'},
  {'<leader>fc', function() require('fzf-lua').command_history() end,      mode = 'n', desc = 'View command history'},
  {'<leader>ff', function() require('fzf-lua').files() end,                mode = 'n', desc = 'Find files'},
  {'<leader>fg', function() require('fzf-lua').live_grep() end,            mode = 'n', desc = 'Live grep'},
  {'<leader>fs', function() require('fzf-lua').lgrep_curbuf() end,         mode = 'n', desc = 'Current buffer fuzzy find'},
  {'<leader>fd', function() require('fzf-lua').diagnostics_document() end, mode = 'n', desc = 'List document diagnostics'},
  {'<leader>gc', function() require('fzf-lua').git_commits() end,          mode = 'n', desc = 'Current buffer fuzzy find'},
  {'<leader>gC', function() require('fzf-lua').git_bcommits() end,         mode = 'n', desc = 'Current buffer fuzzy find'},
  {'<leader>gb', function() require('fzf-lua').git_branches() end,         mode = 'n', desc = 'Current buffer fuzzy find'},

  {'<leader>fs', ':set operatorfunc=GrepOperator<cr>g@',                   mode = 'n', desc = 'Grep operator'},
  {'<leader>fs', ':<c-u>call GrepOperator(visualmode())<cr>',              mode = 'v', desc = 'Grep operator'},
}

vim.api.nvim_exec([[
  function! GrepOperator(type)
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif

    silent execute "lua require('fzf-lua').grep({search='" . @@ . "'})"
  endfunction
]], false)

Plugin.config = true

return Plugin
