local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	build = ':lua require("nightfox").compile()',
}

M.config = function()
	require("nightfox").setup({
		options = {
			transparent = false, -- Disable setting background
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*)
			dim_inactive = false, -- Non focused panes set to alternative background
			styles = { -- Style to be applied to different syntax groups
				comments = "italic",
				conditionals = "NONE",
				constants = "NONE",
				functions = "bold",
				keywords = "bold",
				numbers = "NONE",
				operators = "NONE",
				strings = "italic",
				types = "NONE",
				variables = "NONE",
			},
			inverse = {
				match_paren = false,
				visual = false,
				search = false,
			},
		},
	})
	vim.cmd("colorscheme nightfox")
end

return M
