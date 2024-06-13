---@type LazyPluginSpec
local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
  { "williamboman/mason-lspconfig.nvim" },
  -- { "hrsh7th/cmp-nvim-lsp", optional = true },
}

Plugin.cmd = {
  "LspInfo",
  "LspInstall",
  "LspLog",
  "LspRestart",
  "LspStart",
  "LspStop",
  "LspUninstall",
}

Plugin.event = { "BufReadPre", "BufNewFile" }

local icons = require("util").icons.diagnostics
Plugin.opts = {
  -- options for vim.diagnostic.config()
  ---@type vim.diagnostic.Opts
  diagnostics = {
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.error,
        [vim.diagnostic.severity.WARN] = icons.warn,
        [vim.diagnostic.severity.HINT] = icons.hint,
        [vim.diagnostic.severity.INFO] = icons.info,
      },
    },
  },
  -- add any global capabilities here
  capabilities = {},
  -- LSP Server Settings
  ---@type lspconfig.options
  servers = {},
  -- you can do any additional lsp server setup here
  -- return true if you don't want this server to be setup with lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {},
}

function Plugin.config(_, opts)
  -- Define buffer specific keymaps on LspAttach event
  local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "LSP actions",
    callback = user.on_attach,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- diagnostics signs
  if vim.fn.has("nvim-0.10.0") == 0 then
    for severity, icon in pairs(opts.diagnostics.signs.text) do
      local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end
  end
  -- diagnostics config
  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  local servers = opts.servers
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {}
  )

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  -- get all the servers that are available through mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      elseif server_opts.enabled ~= false then
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
  end
end

-- Define keymapings
function user.on_attach(args)
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
  bufmap({ "n", "x" }, "<F3>", function()
    vim.lsp.buf.format({ async = true })
  end, "")
  bufmap("n", "<F4>", vim.lsp.buf.code_action, "")

  vim.bo[args.buf].tagfunc = "" -- Stop Neovim from setting the LSP as the tag provider
end

return Plugin
