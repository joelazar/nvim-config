-- Mason Python tools configuration
-- Ensures Python linting and formatting tools are installed
return {
  "williamboman/mason.nvim",
  opts = { ensure_installed = { "ruff" } },
}
