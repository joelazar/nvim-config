-- Treesitter configuration
-- Additional language parsers configuration
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  optional = true,
  opts = { ensure_installed = { "sql", "gotmpl", "comment", "css", "latex" } },
}

