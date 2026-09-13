-- Treesitter configuration
-- Additional language parsers on top of LazyVim's defaults
return {
  "nvim-treesitter/nvim-treesitter",
  opts = { ensure_installed = { "sql", "gotmpl", "comment", "css", "latex" } },
}
