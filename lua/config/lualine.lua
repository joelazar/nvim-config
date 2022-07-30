local M = {}

-- disable search count res from the bottom right corner
vim.o.shortmess = vim.o.shortmess .. "S"

local function search_count()
	if vim.api.nvim_get_vvar("hlsearch") == 1 then
		local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })

		if res.total > 0 then
			return string.format("%d/%d", res.current, res.total)
		end
	end

	return ""
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
			"diff",
			{ "diagnostics", sources = { "nvim_diagnostic" } },
		},
		lualine_x = { { search_count, type = "lua_expr" }, "filetype", "fileformat", "encoding" },
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
