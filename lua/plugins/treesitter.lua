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
			"html",
			"http",
			"javascript",
			"jsdoc",
			"json",
			"latex",
			"lua",
			"luadoc",
			"luap",
			"make",
			"markdown",
			"markdown_inline",
			"prisma",
			"python",
			"query",
			"regex",
			"rust",
			"sql",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
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
		indent = { enable = true },
		matchup = { enable = true },
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
