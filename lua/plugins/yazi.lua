return {
  "mikavilpas/yazi.nvim",
  keys = {
    {
      "<leader>y",
      "<cmd>Yazi toggle<cr>",
      desc = "Yazi",
    },
    {
      "<leader>Y",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi - root dir",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
