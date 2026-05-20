-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "ruff", -- Python linting and formatting
      "sqlfluff", -- SQL linting and formatting
      "harper-ls", -- Spelling and grammar checking
      "debugpy", -- Python debug adapter
      "nginx-language-server", -- Nginx LSP
      "oxlint", -- JavaScript/TypeScript linter
      "vtsls", -- TypeScript LSP (not active via LazyVim when tsgo is enabled)
    },
  },
}
