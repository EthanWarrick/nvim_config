local Plugin = { "catppuccin/nvim" }

Plugin.name = "catppuccin"

Plugin.priority = 1000

Plugin.opts = {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    conditionals = {},
  },
  color_overrides = {
    mocha = {
      rosewater = "#ffc9c9",
      flamingo = "#ff9f9a",
      pink = "#ffa9c9",
      mauve = "#df95cf",
      lavender = "#a990c9",
      red = "#ff6960",
      maroon = "#f98080",
      peach = "#f9905f",
      yellow = "#f9bd69",
      green = "#b0d080",
      teal = "#a0dfa0",
      sky = "#a0d0c0",
      sapphire = "#95b9d0",
      blue = "#89a0e0",
      text = "#e0d0b0",
      subtext1 = "#d5c4a1",
      subtext0 = "#bdae93",
      overlay2 = "#928374",
      overlay1 = "#7c6f64",
      overlay0 = "#665c54",
      surface2 = "#504844",
      surface1 = "#3a3634",
      surface0 = "#252525",
      base = "#151515",
      mantle = "#0e0e0e",
      crust = "#080808",
    },
  },
}

Plugin.config = function(_, opts)
  require("catppuccin").setup(opts)
  -- vim.cmd.colorscheme "catppuccin"
end

return Plugin
