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
      auto_integrations = false,
      integrations = {
        blink_cmp = { enabled = true, style = "bordered" },
        dadbod_ui = true,
        dap = true,
        dap_ui = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true, indentscope_color = "overlay2" },
        neotest = true,
        render_markdown = true,
        snacks = true,
        treesitter_context = true,
        which_key = true,
      },
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
