---@type LazyPluginSpec
local Plugin = { "FabijanZulj/blame.nvim" }

Plugin.cmd = { "BlameToggle" }

Plugin.keys = {
  { "<leader>G", "<cmd>BlameToggle<cr>", mode = "n", desc = "Open git blame window" },
}

Plugin.opts = {
  mappings = {
    commit_info = "K",
    stack_push = "<TAB>",
    stack_pop = "<BS>",
    show_commit = "<CR>",
    close = { "<esc>" },
  },
}

return Plugin
