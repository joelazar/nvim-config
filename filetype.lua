vim.filetype.add({
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["[Bb]rewfile%.[%w_.-]+"] = "brewfile",
  },
})

-- Use bash treesitter parser for dotenv files (syntax highlighting)
vim.treesitter.language.register("bash", "dotenv")
