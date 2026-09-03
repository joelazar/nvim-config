-- Session persistence tweaks
-- project.nvim switches cwd to sub-vaults (~/Obsidian/work, ~/Obsidian/private),
-- so a session saved from ~/Obsidian would otherwise land under a different name
-- and `<leader>qs` would not find it. Collapse anything under these roots to one session.
return {
  "folke/persistence.nvim",
  opts = function()
    local P = require("persistence")
    local Config = require("persistence.config")

    local roots = { vim.fn.expand("~/Obsidian") }

    local function session_root(cwd)
      for _, root in ipairs(roots) do
        if cwd == root or cwd:sub(1, #root + 1) == root .. "/" then
          return root
        end
      end
    end

    local current = P.current
    P.current = function(opts)
      local root = session_root(vim.fn.getcwd())
      if not root then
        return current(opts)
      end
      return Config.options.dir .. root:gsub("[\\/:]+", "%%") .. ".vim"
    end
  end,
}
