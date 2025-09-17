-- Mason SQL tools configuration
-- Ensures SQL linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = { ensure_installed = { "sqlfluff" } },
}

