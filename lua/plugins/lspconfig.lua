-- LSP configuration
-- Disables some default LSP keybindings and adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable keymaps
    keys[#keys + 1] = { "<a-p>", false }
    keys[#keys + 1] = { "<a-n>", false }

    -- configure Go LSP servers
    opts.servers = opts.servers or {}
    opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
      settings = {
        gopls = {
          staticcheck = false,
          experimentalPostfixCompletions = true,
        },
      },
    })
    opts.servers.golangci_lint_ls = {}
  end,
}
