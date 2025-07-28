-- Treesitter configuration
-- Additional language parsers configuration
return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = { ensure_installed = { "sql", "gotmpl", "comment", "css", "latex" } },
}

