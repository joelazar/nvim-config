local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		-- Rainbow parentheses by using tree-sitter
		"hiphish/rainbow-delimiters.nvim",
		-- Autocreate/update html tags
		"windwp/nvim-ts-autotag",
		-- Additional textobjects for treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- Show context of the current function
		{
			"nvim-treesitter/nvim-treesitter-context",
			enabled = true,
			opts = { enable = { "lua" }, mode = "cursor", max_lines = 3 },
			keys = {
				{
					"<leader>Ttc",
					function()
						local tsc = require("treesitter-context")
						tsc.toggle()
					end,
					desc = "Toggle context",
				},
			},
		},
	},
	event = { "BufReadPost", "BufNewFile" },
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
			"dap_repl",
			"diff",
			"dockerfile",
			"fish",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"html",
			"http",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"latex",
			"lua",
			"luadoc",
			"luap",
			"make",
			"markdown",
			"markdown_inline",
			"ninja",
			"printf",
			"prisma",
			"python",
			"query",
			"regex",
			"rst",
			"rust",
			"sql",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"zig",
		},
		ignore_install = {},
		sync_install = true,
		autotag = { enable = true },
		highlight = {
			enable = true,
			use_languagetree = true,
			additional_vim_regex_highlighting = { "markdown" },
		},
		indent = { enable = false },
		matchup = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
	})

	vim.api.nvim_create_user_command("TSReload", function()
		vim.cmd([[
      write
      edit
      TSBufEnable highlight
  ]])
	end, {})
end

return M
