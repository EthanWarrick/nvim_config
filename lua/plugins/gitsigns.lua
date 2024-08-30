---@type LazyPluginSpec
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.cmd = "Gitsigns"

-- See :help gitsigns-usage
Plugin.opts = {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        return "]h"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Jump to next hunk" })

    map("n", "[h", function()
      if vim.wo.diff then
        return "[h"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Jump to previous hunk" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk diff" })
    map("n", "<leader>gl", function()
      gs.blame_line(--[[ { full = true } ]])
    end, { desc = "Blame current line" })
    map("n", "<leader>gL", function()
      gs.blame_line({ full = true })
    end, { desc = "Blame current line with diff" })
    map("n", "<leader>gv", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Diff current file changes" })
    map("n", "<leader>gd", gs.toggle_deleted, { desc = "Toggle show deleted lines in change" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk text object" })
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk text object" })
  end,
}

return Plugin
