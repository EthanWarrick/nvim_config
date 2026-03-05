---@module 'gitsigns'
---@type LazyPluginSpec
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.cmd = "Gitsigns"

---@type Gitsigns.Config
---@diagnostic disable-next-line: missing-fields
Plugin.opts = {
  on_attach = function(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Hunk Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, { desc = "Jump to next hunk" })

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, { desc = "Jump to previous hunk" })

    -- Hunk Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })

    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })

    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk diff" })
    map('n', '<leader>hi', gs.preview_hunk_inline, { desc = "Preview hunk inline" })

    -- Hunk Text object
    map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Hunk text object" })
    map({ "o", "x" }, "ah", gs.select_hunk, { desc = "Hunk text object" })

    -- Actions
    map("n", "<leader>gl", gs.blame_line, { desc = "Blame current line" })
    map("n", "<leader>gL", function() gs.blame_line({ full = true }) end, { desc = "Blame current line with diff" })
    map("n", "<leader>gv", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Diff current file changes" })

  end,
}

return Plugin
