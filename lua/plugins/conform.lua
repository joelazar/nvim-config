-- Code formatting configuration
-- Sets up formatters for SQL and Mojo languages
-- Biome/Prettier for JS/TS handled by LazyVim extras:
--   lazyvim.plugins.extras.lang.typescript.biome
--   lazyvim.plugins.extras.formatting.prettier
-- This config also makes prettier yield to biome when a biome config is present,
-- so a global ~/.prettierrc doesn't clobber biome-formatted output.
local function has_biome_config(ctx)
  return vim.fs.root(ctx.dirname, { "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" }) ~= nil
end

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      mojo = { "mojo" },
      sql = { "sqlfluff" },
      mysql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    })

    opts.formatters = opts.formatters or {}

    -- Wrap prettier condition from LazyVim's prettier extra: also skip when biome config exists.
    local prettier = opts.formatters.prettier or {}
    local prev_cond = prettier.condition
    prettier.condition = function(self, ctx)
      if has_biome_config(ctx) then
        return false
      end
      if prev_cond then
        return prev_cond(self, ctx)
      end
      return true
    end
    opts.formatters.prettier = prettier

    opts.formatters.sqlfluff = {
      require_cwd = false,
      args = { "format", "--config", os.getenv("HOME") .. "/.config/nvim/.sqlfluff", "-" },
    }
    opts.formatters.mojo = {
      inherit = false,
      command = "mojo",
      args = { "format", "--quiet", "$FILENAME" },
      stdin = false,
    }
    opts.formatters.shfmt = {
      args = { "-i", "4" },
    }
  end,
}
