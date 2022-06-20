local M = {}

local status_ok, gps = pcall(require, "nvim-gps")
if not status_ok then
	return
end

M.config = {
	options = {
		theme = "nightfox",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		icons_enabled = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{ "filename", path = 1 },
			{ gps.get_location, cond = gps.is_available },
			"diff",
			{ "diagnostics", sources = { "nvim_diagnostic" } },
		},
		lualine_x = { "filetype", "fileformat", "encoding" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	extensions = { "quickfix", "toggleterm", "man" },
}

M.setup = function()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end
	lualine.setup(M.config)
end

return M
