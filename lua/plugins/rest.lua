return {
	{
		"vhyrro/luarocks.nvim",
		branch = "go-away-python",
		config = function()
			require("luarocks").setup({})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup({ env_file = ".envrc" })
		end,
	},
}
