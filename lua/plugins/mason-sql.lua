-- Mason SQL tools configuration
-- Ensures SQL linting and formatting tools are installed
return {
  "williamboman/mason.nvim",
  opts = { ensure_installed = { "sqlfluff" } },
}