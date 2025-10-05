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
        args = { "--config", os.getenv("HOME") .. "/.config/nvim/.markdownlint-cli2.yaml", "--" },
      },
      sqlfluff = { prepend_args = { "--dialect", "postgres" } },
    },
  },
}
