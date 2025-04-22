-- Markdown linting configuration
-- Uses markdownlint-cli2 for linting markdown files
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", os.getenv("HOME") .. "/.config/nvim/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}