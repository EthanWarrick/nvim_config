---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "c", "cpp", "make", "rst" },
  },
}

---@module 'mason'
---@type LazyPluginSpec
local Treesitter_Text_Objects = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  optional = true,
  opts = {
      select = {
        keys = {
          ["ag"] = "@comment.outer",
          ["ig"] = "@comment.outer", -- No built-in inner comment object
        },
      },
  },
}

---@module 'mason'
---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = { ---@type MasonSettings
    ensure_installed = { "clangd" },
  },
}

vim.lsp.config("clangd", { ---@type vim.lsp.Config
  cmd = {
    "clangd",
    "--background-index", -- Index project code in the background
    "--clang-tidy", -- use clang-tidy for code formatting
    "--fallback-style=llvm", -- formatting option if not using clang-tidy
    "--header-insertion=never", -- Don't auto add #include directives
    vim.env.OECORE_NATIVE_SYSROOT
      and vim.env.OECORE_TARGET_ARCH
      and ("--query-driver=" .. vim.env.OECORE_NATIVE_SYSROOT .. "/**/" .. vim.env.OECORE_TARGET_ARCH .. "*"),
  },
})
vim.lsp.enable("clangd")

---@module 'lint'
---@type LazyPluginSpec
local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    ---@type table<string, string[]>
    linters_by_ft = {
      c = { "clangtidy", "checkpatch" },
      cpp = { "clangtidy", "checkpatch" },
      kconfig = { "clangtidy", "checkpatch" },
    },
    ---@type { [string]: lint.Linter }
    linters = {
      ---@diagnostic disable-next-line: missing-fields
      clangtidy = {
        mason = false,
      },
      ---@diagnostic disable-next-line: missing-fields
      checkpatch = {
        cmd = "./scripts/checkpatch.pl",
        condition = function(_)
          return vim.fn.filereadable("./scripts/checkpatch.pl") == 1
        end,
        mason = false,
      },
    },
  },
}

---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      kconfig = { "clang-format" },
    },
  },
}

return { Treesitter, Treesitter_Text_Objects, Mason, Linter, Formatter }
