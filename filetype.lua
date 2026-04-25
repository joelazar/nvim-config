vim.filetype.add({
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["[Bb]rewfile%.[%w_.-]+"] = "brewfile",
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

-- Use bash treesitter parser for dotenv files (syntax highlighting)
vim.treesitter.language.register("bash", "dotenv")
