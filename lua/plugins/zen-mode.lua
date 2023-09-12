return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		plugins = {
			twilight = { enabled = true },
			gitsigns = { enabled = true },
			-- kitty = {
			-- 	enabled = true,
			-- 	font = "+4",
			-- },
		},
		on_open = function(win)
			require("hlargs").disable()
		end,
		on_close = function()
			require("hlargs").enable()
		end,
	},
}
