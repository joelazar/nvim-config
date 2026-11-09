vim.filetype.add({
  pattern = {
    ["[Bb]rewfile%.[%w_.-]+"] = function(path)
      if not path:match("%.lock%.json$") then
        return "ruby"
      end
    end,
  },
})

-- Register LSP filetypes used by nvim-lspconfig so `:checkhealth vim.lsp`
-- does not warn about them. Keep actual detection defaults unchanged.
vim.filetype.add({
  extension = {
    ["yaml.docker-compose"] = "yaml.docker-compose",
    ["yaml.gitlab"] = "yaml.gitlab",
    ["yaml.helm-values"] = "yaml.helm-values",
    ["javascript.jsx"] = "javascript.jsx",
    ["typescript.tsx"] = "typescript.tsx",
  },
})

vim.treesitter.language.register("bash", "env")
