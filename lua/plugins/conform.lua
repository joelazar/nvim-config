-- Code formatting configuration
-- Sets up formatters for SQL and Mojo languages
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      mojo = { "mojo" },
      sql = { "sqlfluff" },
      mysql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        require_cwd = false,
        args = { "format", "--dialect=postgres", "-" },
      },
      mojo = {
        inherit = false,
        command = "mojo",
        args = { "format", "--quiet", "$FILENAME" },
        stdin = false,
      },
    },
  },
}