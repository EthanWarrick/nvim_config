---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
    end
  end,
}

---@type LazyPluginSpec
local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      -- Ensure mason installs the server
      marksman = {},
    },
  },
}

---@type LazyPluginSpec
local Extra = {
  "PratikBhusal/vim-grip",
  dependencies = { "joeyespo/grip", build = "pip3 install ." },
  ft = { "markdown" }, -- Lazy load on these files
  config = function()
    vim.g.grip_default_map = 0 -- Don't use the default plugin keymappings

    vim.keymap.set("n", "<leader>m", "<cmd>GripStart<cr>", { desc = "Start grip and open in browser" })
    vim.keymap.set("n", "<leader>M", "<cmd>GripStop<cr>", { desc = "Kill grip" })
  end,
}

return { Treesitter, LSP, Extra }
