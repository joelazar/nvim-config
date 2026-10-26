-- Mason tools configuration
-- Ensures linting and formatting tools are installed
return {
  "mason-org/mason.nvim",
  init = function()
    -- :MasonUpdateAll updates every installed package and blocks until done (for headless use)
    vim.api.nvim_create_user_command("MasonUpdateAll", function()
      local registry = require("mason-registry")
      local pending, refreshed = 0, false
      registry.refresh(function()
        for _, pkg in ipairs(registry.get_installed_packages()) do
          local installed = pkg:get_installed_version()
          local ok, latest = pcall(pkg.get_latest_version, pkg)
          if ok and latest and latest ~= installed then
            print(("updating %s: %s -> %s"):format(pkg.name, installed or "?", latest))
            pending = pending + 1
            pkg:install({ version = latest }, function(success, err)
              if not success then
                io.stderr:write(("failed to update %s: %s\n"):format(pkg.name, tostring(err)))
              end
              pending = pending - 1
            end)
          end
        end
        refreshed = true
      end)
      vim.wait(900000, function()
        return refreshed and pending <= 0
      end, 200)
    end, { desc = "Update all installed Mason packages" })
  end,
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
