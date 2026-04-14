return {
  "gaoDean/autolist.nvim",
  ft = { "markdown" },
  opts = {},
  keys = {
    { "<CR>", "<CR><cmd>AutolistNewBullet<cr>", ft = "markdown", mode = "i" },
    { "o", "o<cmd>AutolistNewBullet<cr>", ft = "markdown" },
    { "O", "O<cmd>AutolistNewBulletBefore<cr>", ft = "markdown" },
    { "<TAB>", "<cmd>AutolistTab<cr>", ft = "markdown", mode = "i" },
    { "<S-TAB>", "<cmd>AutolistShiftTab<cr>", ft = "markdown", mode = "i" },
  },
}
