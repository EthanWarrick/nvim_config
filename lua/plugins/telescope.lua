local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.enabled = false

Plugin.branch = "0.1.x"

Plugin.dependencies = {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { { "junegunn/fzf", build = "./install --bin" } }, -- Installs fzf utility
    build = "make",
  },
  { "mertzt89/grep-op.nvim", config = true, lazy = false },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
  -- See :help telescope.builtin
  vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
  vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
  vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
  vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
end

Plugin.opts = {
  defaults = {
    layout_strategy = "vertical",
  },
}

function Plugin.config(_, opts)
  require("telescope").setup(opts)
  require("telescope").load_extension("fzf")
end

return Plugin
