local Plugin = { "tzachar/local-highlight.nvim" }

Plugin.event = "BufReadPost"

Plugin.opts = {
  file_types = nil, -- If this is given only attach to this
  -- OR attach to every filetype except:
  disable_file_types = nil,
  hlgroup = "Hover",
  cw_hlgroup = nil,
  -- Whether to display highlights in INSERT mode or not
  insert_mode = false,
}

function Plugin.config(_, opts)
  vim.opt.updatetime = 500 -- Time it takes for highlighting to update

  -- Set the highlight settings for this plugin
  vim.api.nvim_set_hl(0, "Hover", { underline = true })

  require("local-highlight").setup(opts)
end

return Plugin
