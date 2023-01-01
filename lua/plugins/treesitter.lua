local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		-- Rainbow parentheses by using tree-sitter
		"p00f/nvim-ts-rainbow",
		-- Setting the commentstring based on the cursor location in a file
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- Autocreate/update html tags
		"windwp/nvim-ts-autotag",
	},
	event = "BufReadPost",
}

M.config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"comment",
			"cpp",
			"css",
			"dockerfile",
			"fish",
			"go",
			"gomod",
			"html",
			"http",
			"javascript",
			"json",
			"latex",
			"lua",
			"make",
			"prisma",
			"python",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		ignore_install = {},
		sync_install = true,

		autotag = { enable = true },
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		highlight = {
			enable = true,
			use_languagetree = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				scope_incremental = "<CR>",
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>",
			},
		},
		indent = { enable = false },
		matchup = {
			enable = true,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = 2000,
		},
	})
end

return M
