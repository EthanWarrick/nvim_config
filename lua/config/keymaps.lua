-- Set Leader Keys
vim.g.mapleader = " " -- Set leader key as space
vim.g.maplocalleader = "\\" -- Set local leader key as backslash

vim.keymap.set("n", "<esc>", function()
  vim.api.nvim_command("fclose")
  vim.api.nvim_command("nohlsearch")
end, { desc = "Close top floating window & disable search highlight" })

-- Essentially creates a line text object
--  - this is for operating on lines without counting the newline
vim.keymap.set({ "x", "o" }, "al", ":normal! 0v$h<CR>", { desc = "'around-line' text object" })
vim.keymap.set({ "x", "o" }, "il", ":normal! ^vg_<CR>", { desc = "'in-line' text object" })

-- Basic clipboard/register interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gY", '"+Y', { remap = true, desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste to system clipboard" })
vim.keymap.set({ "n", "x" }, "gP", '"+P', { desc = "Paste to system clipboard" })
vim.keymap.set("n", "<C-p>", ":let @+ = @%<cr>", { desc = "Copy relative path to system clipboard" })
vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = 'Delete without saving to " register' })

-- Window Navigation Commands
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Navigate left" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Navigate down" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Navigate up" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Navigate right" })

vim.keymap.set({ "n", "x" }, "<F12>", "<cmd>call GenerateCtags()<CR>", { desc = "Generate tags file" })
vim.api.nvim_exec2(
  [[
  " Ctags
  function! s:CtagsHandler(job_id, data, event)
    if a:event == 'exit'
      echo "Generating Tags... Complete"
    endif
  endfunction
  function! GenerateCtags()
    let l:ctags_cmd = "ctags -R --fields=+Slk --c-types=+deftuxgsmp -B --exclude=build --exclude=megainclude ."
    echo "Generating Tags..."
    if has('nvim')
      let job = jobstart(l:ctags_cmd, {'on_exit': function('s:CtagsHandler')})
    else
      call system(l:ctags_cmd)
      call s:CtagsHandler(0, "", 'exit')
    endif
  endfunction
]],
  {}
)

-- Git Merge Conflict Jumps
local CONFLICT_START = [[^<<<<<<< ]]
local CONFLICT_BASE = [[^||||||| ]]
local CONFLICT_SEP = [[^=======$]]
local CONFLICT_END = [[^>>>>>>> ]]
local CONFLICT = table.concat({CONFLICT_START, CONFLICT_BASE, CONFLICT_SEP, CONFLICT_END}, [[\|]])

-- Returns a table { start, base, sep, end } with the line numbers of each
-- conflict marker for the conflict the cursor is currently inside, or the next
-- one in the file (wrapping). Returns nil if no conflict exists.
---@return { start: integer, base: integer|nil, sep: integer, end: integer }|nil
local function get_conflict_positions()
  local cur_line = vim.fn.line(".")

  local function gather(start_line)
    local saved = vim.fn.getpos(".")
    vim.fn.cursor(start_line, 1)
    local end_line  = vim.fn.search(CONFLICT_END,  "nW")
    local sep_line  = vim.fn.search(CONFLICT_SEP,  "nW")
    local base_line = vim.fn.search(CONFLICT_BASE, "nW")
    vim.fn.setpos(".", saved)
    if end_line == 0 or sep_line == 0 or sep_line > end_line then return nil end
    return {
      ["start"] = start_line,
      ["base"]  = (base_line ~= 0 and base_line < sep_line) and base_line or nil,
      ["sep"]   = sep_line,
      ["end"]   = end_line,
    }
  end

  -- Check if cursor is inside a conflict
  local start_back = vim.fn.search(CONFLICT_START, "nWbc")
  if start_back ~= 0 then
    local conflict = gather(start_back)
    if conflict and conflict["end"] >= cur_line then
      return conflict
    end
  end

  -- Find the next conflict start, with file wrap
  local next_start = vim.fn.search(CONFLICT_START, "nW")
  if next_start == 0 then
    next_start = vim.fn.search(CONFLICT_START, "n")
  end
  if next_start == 0 then return nil end

  return gather(next_start)
end

vim.keymap.set("n", "<leader>x", function()
  local search = CONFLICT
  vim.fn.setreg("/", search)
  vim.fn.histadd("/", search)
  vim.opt.hlsearch = true
end, { silent = true, desc = "Highlight git conflict markers" })

--[[ These mimic default ]c which naviaged vim diff mode ]]
vim.keymap.set({"n", "x", "o"}, "]x", function() vim.fn.search(CONFLICT_START, "s") end, { silent = true, desc = "Jump to start of next git conflict" })
vim.keymap.set({"n", "x", "o"}, "[x", function() vim.fn.search(CONFLICT_START, "sb") end, { silent = true, desc = "Jump to start of previous git conflict" })
vim.keymap.set({"n", "x", "o"}, "]X", function() vim.fn.search(CONFLICT_END, "s") end, { silent = true, desc = "Jump to end of next git conflict" })
vim.keymap.set({"n", "x", "o"}, "[X", function() vim.fn.search(CONFLICT_END, "sb") end, { silent = true, desc = "Jump to end of previous git conflict" })

vim.keymap.set({ "x", "o" }, "ax", function()
  local conflict = get_conflict_positions()
  if not conflict then return end
  vim.cmd("normal ␛")
  vim.fn.cursor(conflict["end"], 1)
  vim.cmd("normal! mz")
  vim.fn.cursor(conflict["start"], 1)
  vim.cmd("normal! V`z")
end, { desc = "'around-conflict' text object" })

vim.keymap.set({ "x", "o" }, "ix", function()
  local conflict = get_conflict_positions()
  if not conflict then return end

  -- Build ordered list of markers (base is optional)
  local markers = { conflict["start"] }
  if conflict["base"] then table.insert(markers, conflict["base"]) end
  table.insert(markers, conflict["sep"])
  table.insert(markers, conflict["end"])

  -- Find the pair of adjacent markers surrounding the cursor,
  -- defaulting to the first section if cursor is before or past all markers.
  local cur = vim.fn.line(".")
  local m1, m2 = markers[1], markers[2]
  for i = 1, #markers - 1 do
    if cur <= markers[i + 1] then
      m1, m2 = markers[i], markers[i + 1]
      break
    end
  end

  vim.cmd("normal ␛")
  vim.cmd("normal! m'")
  vim.fn.cursor(m2 - 1, 1)
  vim.cmd("normal! mz")
  vim.fn.cursor(m1 + 1, 1)
  vim.cmd("normal! V`z")
end, { desc = "'in-conflict' text object" })
