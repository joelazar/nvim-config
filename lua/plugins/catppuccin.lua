-- Catppuccin colorscheme configuration
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = { flavour = "mocha" },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
