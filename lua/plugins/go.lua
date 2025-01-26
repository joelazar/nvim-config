-- Go development plugin configuration
-- Provides enhanced Go language support
return {
	"ray-x/go.nvim",
	-- Required dependencies for Go development
	dependencies = {
		"ray-x/guihua.lua",          -- UI components
		"neovim/nvim-lspconfig",     -- LSP configuration
		"nvim-treesitter/nvim-treesitter", -- Syntax highlighting
	},
	config = function()
		-- Initialize with default settings
		require("go").setup()
	end,
	-- Load only for Go-related files
	ft = { "go", "gomod" },
	-- Install/update Go tools on plugin installation
	build = ':lua require("go.install").update_all_sync()',
}
