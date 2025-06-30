---@type LazyPluginSpec
local Plugin = { "williamboman/mason.nvim" }

Plugin.build = ":MasonUpdate"

Plugin.cmd = {
  "Mason",
  "MasonLog",
  "MasonUpdate",
  "MasonInstall",
  "MasonUninstall",
  "MasonUninstallAll",
}

-- See :help mason-settings
---@type MasonSettings
Plugin.opts = {
  ui = { border = "rounded" },
  ensure_installed = {}, ---@type string[]
}

Plugin.opts_extend = { "ensure_installed" }

---@param opts MasonSettings | {ensure_installed: string[]}
Plugin.config = function(_, opts)
  require("mason").setup(opts)
  local mr = require("mason-registry")
  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- trigger FileType event to possibly load this newly installed LSP server
      require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
      })
    end, 100)
  end)

  -- Check mason registry for packages
  local ensure_installed = {} ---@type string[]
  for _, tool in ipairs(opts.ensure_installed) do
    if mr.has_package(tool) then
      table.insert(ensure_installed, tool)
    else
      vim.notify("Package not in Mason registry: " .. tool, vim.log.levels.WARN)
    end
  end

  -- Install packages from mason registry
  mr.refresh(function()
    for _, tool in ipairs(ensure_installed or {}) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return Plugin
