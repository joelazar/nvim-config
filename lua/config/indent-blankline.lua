local M = {}

M.config = {
	space_char_blankline = " ",
	buftype_exclude = { "telescope" },
	filetype_exclude = {
		"starter",
		"packer",
		"Trouble",
		"TelescopePrompt",
		"Float",
		"OverseerForm",
	},
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
