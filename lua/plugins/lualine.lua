local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
}

M.config = function()
	require("lualine").setup({
		options = {
			theme = "catppuccin",
			globalstatus = true,
			disabled_filetypes = { statusline = { "starter" } },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{
					"filename",
					path = 1,
					symbols = { modified = "", readonly = "  readonly", unnamed = "" },
				},
			},
			lualine_x = { "searchcount", "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "lazy", "man", "nvim-dap-ui", "overseer", "quickfix", "toggleterm", "trouble" },
	})
end

return M
