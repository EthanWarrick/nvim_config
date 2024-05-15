local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "python", "rst" })
    end
  end,
}

local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      -- Ensure mason installs the server
      pylsp = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      },
      ruff_lsp = {}, -- Additional ruff diagnostics
    },
  },
}

local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      python = { "ruff" },
    },
  },
}

return { Treesitter, LSP, Formatter }
