-- Blink.cmp configuration
-- Autocompletion plugin with multiple sources
return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-git",
    "Kaiser-Yang/blink-cmp-dictionary",
    "joelazar/blink-calc",
  },
  opts = {
    keymap = {
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
          opts = {
            currency_rates = "er-api",
          },
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
          max_items = 10,
          opts = {
            dictionary_files = { vim.fn.expand("~/.config/dict/words.txt") },
          },
        },
      },
    },
  },
}
