local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				-- default options: exact mode, multi window, all directions, with a backdrop
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			-- show labeled treesitter nodes around the cursor
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "x", "o" },
			function()
				-- show labeled treesitter nodes around the search matches
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
	},
}

return M
