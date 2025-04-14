---@type LazyPluginSpec
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
  min_match_len = 1,
  max_match_len = math.huge,
  highlight_single_match = true,
  animate = {
    enabled = false,
    easing = "linear",
    duration = {
      step = 10, -- ms per step
      total = 100, -- maximum duration
    },
  },
  debounce_timeout = 200,
}

function Plugin.config(_, opts)
  vim.opt.updatetime = 500 -- Time it takes for highlighting to update

  -- Set the highlight settings for this plugin
  vim.api.nvim_set_hl(0, "Hover", { underline = true })

  require("local-highlight").setup(opts)
end

return Plugin
