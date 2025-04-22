-- Orphans plugin configuration
-- Helps to find orphaned files in your project
return {
  "ZWindL/orphans.nvim",
  config = function()
    require("orphans").setup({})
  end,
  cmd = { "Orphans" },
}