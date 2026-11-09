-- Code formatting configuration
-- Sets up formatters for SQL
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

    -- Prettier for markdown that leaves YAML frontmatter untouched.
    opts.formatters.prettier_body = {
      format = function(_, ctx, lines, callback)
        local fm_end = 0
        if lines[1] == "---" then
          for i = 2, #lines do
            if lines[i] == "---" then
              fm_end = i
              break
            end
          end
        end
        local frontmatter = vim.list_slice(lines, 1, fm_end)
        local body = vim.list_slice(lines, fm_end + 1)
        vim.system(
          { "prettier", "--stdin-filepath", ctx.filename },
          { cwd = ctx.dirname, stdin = table.concat(body, "\n") .. "\n", text = true },
          vim.schedule_wrap(function(res)
            if res.code ~= 0 then
              return callback(res.stderr ~= "" and res.stderr or "prettier failed")
            end
            local out = vim.split(res.stdout, "\n", { plain = true })
            if out[#out] == "" then
              table.remove(out)
            end
            -- prettier strips leading blank lines; keep the one separating frontmatter from body
            if fm_end > 0 and body[1] == "" and out[1] ~= "" then
              table.insert(out, 1, "")
            end
            callback(nil, vim.list_extend(frontmatter, out))
          end)
        )
      end,
    }
    for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
      local list = opts.formatters_by_ft[ft]
      if list then
        for i, name in ipairs(list) do
          if name == "prettier" then
            list[i] = "prettier_body"
          end
        end
      end
    end

    -- Obsidian vaults: rumdl keeps Obsidian's 2-space nesting under ordered lists, prettier/markdownlint split them.
    local obsidian_root = vim.fn.expand("~/Obsidian") .. "/"
    local markdown_default = opts.formatters_by_ft.markdown
    opts.formatters_by_ft.markdown = function(bufnr)
      if vim.startswith(vim.api.nvim_buf_get_name(bufnr), obsidian_root) then
        return { "rumdl" }
      end
      return markdown_default
    end
    opts.formatters.rumdl = {
      args = {
        "fmt",
        "--flavor",
        "obsidian",
        "--quiet",
        "--extend-disable",
        "MD076",
        "--stdin-filename",
        "$FILENAME",
        "-",
      },
    }

    opts.formatters.sqlfluff = {
      require_cwd = false,
      args = { "format", "--config", vim.fn.stdpath("config") .. "/.sqlfluff", "-" },
    }
    opts.formatters.shfmt = {
      args = { "-filename", "$FILENAME", "-i", "4" },
    }
  end,
}
