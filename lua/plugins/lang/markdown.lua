return {

  -- Treesitter
  require("util").ts_ensure_installed({ "markdown" }),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- Ensure mason installs the server
        marksman = {},
      },
    },
  },

  -- A plugin to activate the python package grip to view markdown
  --  files in a browser.
  {
    "PratikBhusal/vim-grip",
    dependencies = { "joeyespo/grip", build = "pip3 install ." },
    ft = { "md", "mkdn", "mdown", "markdown" }, -- Lazy load on these files
    config = function()
      vim.g.grip_default_map = 0 -- Don't use the default plugin keymappings

      vim.keymap.set("n", "<leader>m", "<cmd>GripStart<cr>", { desc = "Start grip and open in browser" })
      vim.keymap.set("n", "<leader>M", "<cmd>GripStop<cr>", { desc = "Kill grip" })
    end,
  },
}
