-- LSP configuration for Go
-- Adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      golangci_lint_ls = {},
    },
  },
}