return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		plugins = {
			twilight = { enabled = true },
			gitsigns = { enabled = true },
			kitty = {
				enabled = true,
				font = "+4",
			},
		},
	},
}
