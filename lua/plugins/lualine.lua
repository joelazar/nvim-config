local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	event = "VeryLazy",
}

M.config = function()
	require("lualine").setup({
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
				"overseer",
			},
			lualine_x = {
				"searchcount",
				"filetype",
				"fileformat",
				"encoding",
			},
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
	})
end

return M
