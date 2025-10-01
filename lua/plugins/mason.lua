-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "ruff",    -- Python linting and formatting
      "sqlfluff", -- SQL linting and formatting
    },
  },
}
