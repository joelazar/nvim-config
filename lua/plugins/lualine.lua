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
			theme = "auto",
			globalstatus = true,
			disabled_filetypes = { statusline = { "starter" } },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"diff",
				"diagnostics",
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
			},
			lualine_x = {
				"searchcount",
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "quickfix", "toggleterm", "man", "nvim-dap-ui" },
	})
end

return M
