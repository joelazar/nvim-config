-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "debugpy", -- Python debug adapter
      "harper-ls", -- Spelling and grammar checking
      "nginx-language-server", -- Nginx LSP
      "ruff", -- Python linting and formatting
      "rust-analyzer", -- Rust LSP
      "sqlfluff", -- SQL linting and formatting
      "ty", -- Python LSP
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    vim.defer_fn(function()
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end, 500)
  end,
}
