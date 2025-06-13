---@type LazyPluginSpec
local Plugin = { "neovim/nvim-lspconfig" }

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

Plugin.opts = {
  -- add any global capabilities here
  capabilities = {},
  -- LSP Server Settings
  ---@type lspconfig.options
  servers = {
    -- [lsp_server] = {
    --   enabled? boolean
    --   single_file_support? boolean
    --   silent? boolean
    --   filetypes? string[]
    --   filetype? string
    --   on_new_config? fun(new_config: lspconfig.Config?, new_root_dir: string)
    --   autostart? boolean
    --   package _on_attach? fun(client: vim.lsp.Client, bufnr: integer)
    --   root_dir? string|fun(filename: string, bufnr: number)
    --   commands? table<string, lspconfig.Config.command>
    --   mason? boolean
    -- }
  },
  -- you can do any additional lsp server setup here
  -- return true if you don't want this server to be setup with lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {},
}

function Plugin.config(_, opts)
  local servers = opts.servers
  local has_cmp, cmp_nvim_lsp = pcall(require, "blink.cmp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.get_lsp_capabilities() or {},
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
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
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

return Plugin
