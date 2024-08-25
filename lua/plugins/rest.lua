return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		branch = "go-away-python",
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim", "j-hui/fidget.nvim" },
		config = function()
			require("rest_nvim").setup({ env_file = ".envrc" })
		end,
	},
}
