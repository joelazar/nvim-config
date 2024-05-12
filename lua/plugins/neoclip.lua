return {
	"AckslD/nvim-neoclip.lua",
	event = "VeryLazy",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
		})
	end,
}
