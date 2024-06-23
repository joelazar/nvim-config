return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	config = function()
		require("project_nvim").setup({
			patterns = { "go.mod", ".git", "Makefile", ".obsidian" },
		})
	end,
}
