-- LSP keymaps configuration
-- Disables some default LSP keybindings
return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable mappings
    keys[#keys + 1] = { "<a-p>", false }
    keys[#keys + 1] = { "<a-n>", false }
  end,
}