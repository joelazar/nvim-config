-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "debugpy", -- Python debug adapter
      "harper-ls", -- Spelling and grammar checking
      "nginx-language-server", -- Nginx LSP
      "oxlint", -- JavaScript/TypeScript linter
      "ruff", -- Python linting and formatting
      "rust-analyzer", -- Rust LSP
      "sqlfluff", -- SQL linting and formatting
      "vtsls", -- TypeScript LSP (not active via LazyVim when tsgo is enabled)
    },
  },
}
