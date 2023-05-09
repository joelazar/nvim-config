local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	build = ':lua require("nightfox").compile()',
}

M.config = function()
	require("nightfox").setup({
		options = {
			-- Compiled file's destination location
			compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			compile_file_suffix = "_compiled", -- Compiled file suffix
			transparent = false, -- Disable setting background
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*)
			dim_inactive = false, -- Non focused panes set to alternative background
			module_default = true, -- Default enable value for modules
			colorblind = {
				enable = false, -- Enable colorblind support
				simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
				severity = {
					protan = 0, -- Severity [0,1] for protan (red)
					deutan = 0, -- Severity [0,1] for deutan (green)
					tritan = 0, -- Severity [0,1] for tritan (blue)
				},
			},
			styles = {
				-- Style to be applied to different syntax groups
				comments = "italic",
				conditionals = "NONE",
				constants = "NONE",
				functions = "bold",
				keywords = "bold",
				numbers = "NONE",
				operators = "NONE",
				strings = "italic",
				types = "italic,bold",
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
