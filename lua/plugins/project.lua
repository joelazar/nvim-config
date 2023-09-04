return {
	"ahmedkhalf/project.nvim",
	event = { "VimEnter" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("project_nvim").setup({
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			patterns = { ".git", "Makefile", "package.json" },
			ignore_lsp = {},
			exclude_dirs = {},
			show_hidden = false,
			silent_chdir = true,
			scope_chdir = "global",
			datapath = vim.fn.stdpath("data"),
		})

		require("telescope").load_extension("projects")
	end,
}
