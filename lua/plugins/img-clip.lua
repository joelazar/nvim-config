return {
	"HakonHarnes/img-clip.nvim",
	opts = {
		default = {
			dir_path = "_assets",
		},
	},
	cmd = "PasteImage",
	keys = {
		{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image" },
	},
}
