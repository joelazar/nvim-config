-- Text Case plugin configuration
-- Provides case conversion utilities
return {
  "johmsalas/text-case.nvim",
  keys = { { "ga", mode = { "n", "x" } } },
  cmd = { "Subs", "TextCaseStartReplacingCommand" },
  config = function()
    require("textcase").setup({})
  end,
}
