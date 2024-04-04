local Plugin = { "mfussenegger/nvim-lint" }

Plugin.dependencies = { "williamboman/mason.nvim" }

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
  -- Event to trigger linters
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  linters_by_ft = {
    -- [filetype] = { "language linter" },
    -- ['*'] = { 'global linter' }, -- Run linters on all filetypes.
    -- ['_'] = { 'fallback linter' }, -- Run linters on filetypes that don't have other linters configured.
  },
  linters = {
    -- [filetype] = {
    --   cmd = 'linter_cmd',
    --   condition = function(ctx) end, -- allows you to dynamically enable/disable linters based on the context.
    --   stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
    --   append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
    --   args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
    --   stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
    --   ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
    --   env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
    --   parser = your_parse_function
    -- }
  },
}

Plugin.config = function(_, opts)
  local M = {}

  -- Configure custom linters
  local lint = require("lint")
  for name, linter in pairs(opts.linters) do
    if type(linter) == "table" and type(lint.linters[name]) == "table" then
      lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
    else
      lint.linters[name] = linter
    end
  end

  -- Check mason registry for linter packages
  local mr = require("mason-registry")
  local ensure_installed = {} ---@type string[]
  for _, linters in pairs(opts.linters_by_ft) do
    for _, linter in ipairs(linters) do
      if pcall(mr.get_package, linter) then
        ensure_installed = vim.list_extend(ensure_installed, { linter })
      end
    end
  end

  -- Install linter packages from mason registry
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

  -- Pass linters to plugin
  lint.linters_by_ft = opts.linters_by_ft

  -- Enable diagnostics keybindings
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to previous diagnostic" })

  function M.debounce(ms, fn)
    local timer = vim.loop.new_timer()
    return function(...)
      local argv = { ... }
      timer:start(ms, 0, function()
        timer:stop()
        vim.schedule_wrap(fn)(unpack(argv))
      end)
    end
  end

  function M.lint()
    -- Use nvim-lint's logic first:
    -- * checks if linters exist for the full filetype first
    -- * otherwise will split filetype by "." and add all those linters
    -- * this differs from conform.nvim which only uses the first filetype that has a formatter
    local names = lint._resolve_linter_by_ft(vim.bo.filetype)

    -- Add fallback linters.
    if #names == 0 then
      vim.list_extend(names, lint.linters_by_ft["_"] or {})
    end

    -- Add global linters.
    vim.list_extend(names, lint.linters_by_ft["*"] or {})

    -- Filter out linters that don't exist or don't match the condition.
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      if not linter then
        vim.notify("Linter not found: " .. name, vim.log.levels.WARN)
      end
      return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
    end, names)

    -- Run linters.
    if #names > 0 then
      lint.try_lint(names)
    end
  end

  vim.api.nvim_create_autocmd(opts.events, {
    group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
    callback = M.debounce(100, M.lint),
  })
end

return Plugin
