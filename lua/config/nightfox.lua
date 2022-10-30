local M = {}

M.config = {
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
}

M.setup = function()
	local status_ok, nightfox = pcall(require, "nightfox")
	if not status_ok then
		return
	end
	nightfox.setup(M.config)
	vim.cmd("colorscheme nightfox")
end

return M
