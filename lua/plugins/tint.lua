local Plugin = { "levouh/tint.nvim" }

-- Plugin.event = { "WinEnter" } -- Enables Tint on entering another window
Plugin.cmd = { "TintEnable", "TintDisable", "TintToggle" }

Plugin.opts = {
  tint = -55, -- Determines the intensity of dimming
  window_ignore_function = function(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
    local diff = vim.api.nvim_win_get_option(winid, "diff")

    -- Do not tint `terminal`, floating windows or diff tint everything else
    return buftype == "terminal" or floating or diff
  end,
  highlight_ignore_patterns = { "WinSeparator", "Status.*", "lualine_*" },
}

Plugin.config = function(_, opts)
  require("tint").setup(opts)
  vim.api.nvim_create_user_command(
    "TintEnable",
    require("tint").enable,
    { desc = "Enbale dimming of inactive windows" }
  )
  vim.api.nvim_create_user_command(
    "TintDisable",
    require("tint").disable,
    { desc = "Disable dimming of inactive windows" }
  )
  vim.api.nvim_create_user_command(
    "TintToggle",
    require("tint").toggle,
    { desc = "Toggle dimming of inactive windows" }
  )
end

return Plugin
