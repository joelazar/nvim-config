local M = {}

M.config = {
	char = "│",
	show_first_indent_level = true,
	filetype_exclude = {
		"startify",
		"dashboard",
		"dotooagenda",
		"log",
		"fugitive",
		"gitcommit",
		"packer",
		"vimwiki",
		"markdown",
		"json",
		"txt",
		"vista",
		"help",
		"todoist",
		"NvimTree",
		"peekaboo",
		"git",
		"TelescopePrompt",
		"undotree",
		"flutterToolsOutline",
		"", -- for all buffers without a file type
	},
	buftype_exclude = { "terminal", "nofile" },
	show_trailing_blankline_indent = true,
	show_current_context = true,
	indent_blankline_show_end_of_line = true,
	context_patterns = {
		"class",
		"function",
		"method",
		"block",
		"list_literal",
		"selector",
		"^if",
		"^table",
		"if_statement",
		"while",
		"for",
		"type",
		"var",
		"import",
	},
	space_char_blankline = " ",
}

M.config_function = function()
	vim.opt.listchars:append("space:⋅")
	vim.opt.listchars:append("eol:↴")
end

M.setup = function()
	local status_ok, indent_blankline = pcall(require, "indent_blankline")
	if not status_ok then
		return
	end
	M.config_function()
	indent_blankline.setup(M.config)
end

return M
