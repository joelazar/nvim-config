return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>y",
      "<cmd>Yazi<cr>",
      desc = "Yazi - current dir",
    },
    {
      "<leader>Y",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi - root dir",
    },
    {
      "<c-y>",
      "<cmd>Yazi toggle<cr>",
      desc = "Yazi - resume session",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
