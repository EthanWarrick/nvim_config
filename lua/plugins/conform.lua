---@type LazyPluginSpec
local Plugin = { "stevearc/conform.nvim" }

Plugin.dependencies = { "williamboman/mason.nvim" }

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = false }
  end,
  formatters_by_ft = {},
}

Plugin.config = function(_, opts)
  -- Obtain formatters
  local ensure_installed = {} ---@type string[]
  for _, formatters in pairs(opts.formatters_by_ft) do
    ensure_installed = vim.list_extend(ensure_installed, formatters)
  end

  -- Install formatter packages from mason registry
  local mr = require("mason-registry")
  local function mason_try_install()
    for _, formatter in ipairs(ensure_installed) do
      local p = mr.get_package(formatter)
      if not p:is_installed() then
        p:install()
      end
    end
  end
  if mr.refresh then
    mr.refresh(vim.schedule_wrap(mason_try_install))
  else
    mason_try_install()
  end

  require("conform").setup(opts)

  vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ["end"] = { args.line2, end_line:len() },
      }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
  end, { range = true })

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

return Plugin
