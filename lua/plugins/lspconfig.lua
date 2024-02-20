local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
  { "williamboman/mason-lspconfig.nvim" },
  -- { "hrsh7th/cmp-nvim-lsp", optional = true },
}

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
  local sign = function(opts)
    -- See :help sign_define()
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = "",
    })
  end

  sign({ name = "DiagnosticSignError", text = "✘" })
  sign({ name = "DiagnosticSignWarn", text = "▲" })
  sign({ name = "DiagnosticSignHint", text = "⚑" })
  sign({ name = "DiagnosticSignInfo", text = "»" })

  -- See :help vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

function Plugin.config(_, opts)
  -- See :help lspconfig-global-defaults
  local lspconfig = require("lspconfig")

  if not opts.servers then
    return -- Skip config if there are no servers specified
  end

  -- Define buffer specific keymaps on LspAttach event
  local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "LSP actions",
    callback = user.on_attach,
  })

  -- Gather configured servers to install
  -- See :lua =vim.lsp.get_active_clients()[1] for specific LSP info
  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(opts.servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      ensure_installed[#ensure_installed + 1] = server
    end
  end

  -- See :help mason-lspconfig-settings
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
      -- See :help mason-lspconfig-dynamic-server-setup
      function(server)
        local server_opts = opts.servers[server]
        if opts.setup and opts.setup[server] then
          opts.setup[server](server, server_opts)
          return
        else
          -- See :help lspconfig-setup
          lspconfig[server].setup(server_opts)
        end
      end,
    },
  })
end

-- Define keymapings
function user.on_attach()
  local bufmap = function(mode, lhs, rhs, desc)
    local opts = { buffer = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- You can search each function in the help page.
  -- For example :help vim.lsp.buf.hover()
  bufmap("n", "<leader><space>", vim.lsp.buf.hover, "Open hover preview")
  bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
  bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declartation")
  bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  bufmap("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
  bufmap("n", "gr", vim.lsp.buf.references, "List references")
  bufmap("n", "gl", vim.diagnostic.open_float, "Open diagnostic float")
  bufmap("n", "[d", vim.diagnostic.goto_prev, "Go to next diagnostic")
  bufmap("n", "]d", vim.diagnostic.goto_next, "Go to previous diagnostic")
  -- bufmap('n', 'gs', vim.lsp.buf.signature_help, "")
  bufmap("n", "<F2>", vim.lsp.buf.rename, "")
  -- bufmap({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({async = true}) end, "")
  -- bufmap("n", "<F4>", vim.lsp.buf.code_action, "")
end

return Plugin
