-- Blink.cmp configuration
-- Autocompletion plugin with multiple sources
return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "Kaiser-Yang/blink-cmp-git",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "Kaiser-Yang/blink-cmp-dictionary",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "blink-calc",
      dir = "/Users/joelazar/Code/joelazar/blink-calc",
    },
  },
  opts = {
    keymap = {
      -- ["<Tab>"] = { LazyVim.cmp.map({ "snippet_forward" }), "select_next", "fallback" },
      -- ["<S-Tab>"] = { LazyVim.cmp.map({ "snippet_backward" }), "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Esc>"] = { "hide", "fallback" },
      ["<C-j>"] = { "select_and_accept" },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
    },
    sources = {
      default = { "git", "dictionary", "calc" },
      providers = {
        calc = {
          name = "Calc",
          module = "blink-calc",
        },
        git = {
          module = "blink-cmp-git",
          name = "Git",
          opts = {},
        },
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          min_keyword_length = 3,
          opts = {},
        },
      },
    },
  },
}
