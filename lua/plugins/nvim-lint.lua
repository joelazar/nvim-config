-- Markdown linting configuration
-- Uses markdownlint-cli2 for linting markdown files
-- SQL linting configuration
-- Configures sqlfluff linter for SQL dialects

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      sql = { "sqlfluff" },
      mysql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint-cli2.yaml", "--" },
      },
      sqlfluff = { args = { "lint", "--format=json", "--config", vim.fn.stdpath("config") .. "/.sqlfluff", "-" } },
    },
  },
}
