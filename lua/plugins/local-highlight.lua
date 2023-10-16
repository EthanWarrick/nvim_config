local Plugin = {'tzachar/local-highlight.nvim'}

Plugin.name = 'local-highlight'

Plugin.opts = {
  file_types = nil, -- If this is given only attach to this
  -- OR attach to every filetype except:
  disable_file_types = nil,
  hlgroup = 'Hover',
  cw_hlgroup = nil,
  -- Whether to display highlights in INSERT mode or not
  insert_mode = false,
}

function Plugin.init()
  vim.opt.updatetime = 500 -- Time it takes for highlighting to update

  -- Set the highlight settings for this plugin
  local ns_id = vim.api.nvim_create_namespace('')
  vim.api.nvim_set_hl(
    ns_id,
    'Hover',
    {underline=true,}
  )
  vim.api.nvim_set_hl_ns(ns_id)
end

return Plugin
