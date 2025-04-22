-- Text Case plugin configuration
-- Provides case conversion utilities
return {
  "johmsalas/text-case.nvim",
  config = function()
    require("textcase").setup({})
  end,
}