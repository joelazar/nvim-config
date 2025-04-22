-- Which-key configuration
-- Shows keybinding hints in a popup
return {
  "folke/which-key.nvim",
  opts = {
    preset = "helix",
    icons = {
      mappings = false,
      rules = false,
    },
    spec = {
      {
        mode = { "n" },
        { "<leader>W", '<cmd>lua require("config.utils").sudo_write()<cr>', desc = "Write (sudo)" },
      },
    },
  },
}