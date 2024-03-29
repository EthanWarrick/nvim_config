return {

  -- Treesitter
  require("util").ts_ensure_installed({ "c", "cpp", "make", "rst" }),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            -- "--log=verbose",
            "--background-index", -- Index project code in the background
            "--clang-tidy", -- use clang-tidy for code formatting
            "--fallback-style=llvm", -- formatting option if not using clang-tidy
            -- "--header-insertion=iwyu", -- Add #include directive when accepting code completions
            -- "--completion-style=detailed", -- Code completion
            -- "--function-arg-placeholders", -- Code completion
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  -- Clangd Extensions
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ft = { "c", "h", "cpp", "hpp", "hxx" },
    opts = {
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
}
