local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
  { "williamboman/mason-lspconfig.nvim" },
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
  local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = true }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- You can search each function in the help page.
  -- For example :help vim.lsp.buf.hover()

  bufmap("n", "<leader><space>", "<cmd>lua vim.lsp.buf.hover()<cr>")
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
  bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
  -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
  bufmap({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
  bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
  bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
  bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

return Plugin
