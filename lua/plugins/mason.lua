-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = vim.tbl_filter(function(tool)
      return tool ~= "ansible-lint"
    end, opts.ensure_installed or {})
    vim.list_extend(opts.ensure_installed, {
      "debugpy", -- Python debug adapter
      "harper-ls", -- Spelling and grammar checking
      "nginx-language-server", -- Nginx LSP
      "ruff", -- Python linting and formatting
      "rust-analyzer", -- Rust LSP
      "sqlfluff", -- SQL linting and formatting
      "ty", -- Python LSP
    })
  end,
}
