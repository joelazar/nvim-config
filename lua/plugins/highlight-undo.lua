return {
	"tzachar/highlight-undo.nvim",
	opts = {
		hlgroup = "BufferCurrentCHANGED",
		duration = 500,
		keymaps = {
			{ "n", "u", "undo", {} },
			{ "n", "<C-r>", "redo", {} },
		},
	},
	event = "VeryLazy",
}
