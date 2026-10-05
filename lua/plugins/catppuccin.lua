-- Catppuccin colorscheme configuration
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      term_colors = true,
      auto_integrations = true,
    },
  },
  -- let LazyVim apply the colorscheme (and re-apply it after lazy loads)
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
  -- don't keep LazyVim's default colorscheme around
  { "folke/tokyonight.nvim", enabled = false },
}
