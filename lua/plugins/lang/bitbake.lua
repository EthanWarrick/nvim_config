local Treesitter = require("util").ts_ensure_installed({ "bitbake" })

-- local LSP = {
--   "Freed-Wu/bitbake-language-server",
--   -- build = "pip3.12 install .",
--   build = "pip3.12 install bitbake-language-server",
--   ft = "bitbake",
--   -- init = function()
--   --   -- Set conf files as bitbake filetypes
--   --   -- pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
--   -- end,
--   config = function()
--     vim.api.nvim_create_autocmd({ "BufEnter" }, {
--       pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
--       callback = function()
--         vim.lsp.start({
--           name = "bitbake",
--           cmd = { "bitbake-language-server" },
--         })
--       end,
--     })
--   end,
-- }

local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      bitbake = { "oelint-adv" },
    },
  },
}

return { Treesitter, Linter }
