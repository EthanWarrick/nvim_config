local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd("BufLeave", {
  desc = "Save window view position",
  group = group,
  callback = function()
    vim.api.nvim_exec2(
      [[
      if !exists("w:SavedBufView")
          let w:SavedBufView = {}
      endif
      let w:SavedBufView[bufnr("%")] = winsaveview()
      ]],
      {}
    )
  end,
})

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Restore window view position",
  group = group,
  callback = function()
    vim.api.nvim_exec2(
      [[
      let buf = bufnr("%")
      if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
          let v = winsaveview()
          let atStartOfFile = v.lnum == 1 && v.col == 0
          if atStartOfFile && !&diff
              call winrestview(w:SavedBufView[buf])
          endif
          unlet w:SavedBufView[buf]
      endif
      ]],
      {}
    )
  end,
})

local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
-- Define buffer specific keymaps on LspAttach event
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_cmds,
  desc = "LSP Define Keymaps",
  callback = function(args)
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = true, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()
    bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declartation")
    bufmap("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
    bufmap("n", "gl", vim.diagnostic.open_float, "Open diagnostic float")
    -- bufmap('n', 'gs', vim.lsp.buf.signature_help, "")
    bufmap({ "n", "x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end, "")
    bufmap("n", "<F4>", vim.lsp.buf.code_action, "")

    vim.bo[args.buf].tagfunc = "" -- Stop Neovim from setting the LSP as the tag provider
  end,
})
