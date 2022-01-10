local M = {}

M.config = {
	options = {
		theme = "nightfox",
		section_separators = { "", "" },
		component_separators = "|",
		icons_enabled = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{ "filename", path = 1 },
			{ "diagnostics", sources = { "nvim_diagnostic" } },
			"diff",
		},
		lualine_x = { "filetype", "encoding" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "quickfix", "toggleterm" },
}

M.setup = function()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end
	lualine.setup(M.config)
end

return M
