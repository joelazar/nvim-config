return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			mappings = {
				n = {
					q = "Close",
				},
			},
			default_prompt = "➤ ",
		},
		select = {
			backend = { "telescope" },
			telescope = require("telescope.themes").get_ivy({
				sorting_strategy = "descending",
				layout_config = {
					height = 12,
				},
			}),
			mappings = {
				n = {
					q = "Close",
				},
			},
		},
	},
}
