-- Git blame integration
-- Shows git blame information in the current buffer
return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup()
  end,
  cmd = "BlameToggle",
}