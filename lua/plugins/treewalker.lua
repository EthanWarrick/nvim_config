local Plugin = { "aaronik/treewalker.nvim" }

Plugin.keys = {
  -- movement
  { "<Up>", "<cmd>Treewalker Up<cr>", mode = { "n", "v" }, silent = true, desc = "Moves up to the previous neighbor node" },
  { "<Down>", "<cmd>Treewalker Down<cr>", mode = { "n", "v" }, silent = true, desc = "Moves down to the next neighbor node" },
  { "<Left>", "<cmd>Treewalker Left<cr>", mode = { "n", "v" }, silent = true, desc = "Moves to the first ancestor node that's on a different line from the current node" },
  { "<Right>", "<cmd>Treewalker Right<cr>", mode = { "n", "v" }, silent = true, desc = "Moves to the next node down that's indented further than the current node" },

  -- swapping
  { "<C-Up>", "<cmd>Treewalker SwapUp<cr>", silent = true, desc = "Swaps the highest node on the line upwards in the document" },
  { "<C-Down>", "<cmd>Treewalker SwapDown<cr>", silent = true, desc = "Swaps the biggest node on the line downward in the document" },
  { "<C-Left>", "<cmd>Treewalker SwapLeft<cr>", silent = true, desc = "Swap the node under the cursor with its previous neighbor" },
  { "<C-Right>", "<cmd>Treewalker SwapRight<cr>", silent = true, desc = "Swap the node under the cursor with its next neighbor" },
}

Plugin.cmd = {
  "Treewalker",
    -- "Treewalker Up",
    -- "Treewalker Down",
    -- "Treewalker Left",
    -- "Treewalker Right",
    -- "Treewalker SwapUp",
    -- "Treewalker SwapDown",
    -- "Treewalker SwapLeft",
    -- "Treewalker SwapRight",
}

return Plugin
