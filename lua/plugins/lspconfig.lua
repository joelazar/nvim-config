-- LSP configuration
-- Disables some default LSP keybindings and adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable mappings
    keys[#keys + 1] = { "<a-p>", false }
    keys[#keys + 1] = { "<a-n>", false }

    -- add Go server
    opts.servers = opts.servers or {}
    opts.servers.golangci_lint_ls = {}
  end,
}

