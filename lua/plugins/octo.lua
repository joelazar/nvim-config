return {
  "pwntester/octo.nvim",
  config = function()
    require("octo").setup()
    require("telescope").load_extension("octo")
  end,
  cmd = { "Octo" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
