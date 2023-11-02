return {
	"ahmedkhalf/project.nvim",
	event = { "VimEnter" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("project_nvim").setup({
			manual_mode = true,
		})
		require("telescope").load_extension("projects")
	end,
}
