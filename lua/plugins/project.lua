-- Project management configuration
-- Automatically detects and switches working directory based on project files
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      patterns = { "go.mod", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".obsidian" },
    })
  end,
}