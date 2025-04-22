-- SQL linting configuration
-- Configures sqlfluff linter for SQL dialects
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      sql = { "sqlfluff" },
      mysql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    },
    linters = {
      sqlfluff = { prepend_args = { "--dialect", "postgres" } },
    },
  },
}