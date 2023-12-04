local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
}

M.config = function()
	local function is_textfile()
		local filetype = vim.bo.filetype
		return filetype == "markdown"
			or filetype == "asciidoc"
			or filetype == "pandoc"
			or filetype == "tex"
			or filetype == "text"
	end
	local function wordcount()
		local wc = vim.fn.wordcount()
		local visual_words = wc.visual_words or wc.words
		local word_string = visual_words == 1 and " word" or " words"
		return tostring(visual_words) .. word_string
	end

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
			lualine_z = {
				{ wordcount, cond = is_textfile },
				"location",
			},
		},
		extensions = { "lazy", "man", "nvim-dap-ui", "overseer", "quickfix", "toggleterm", "trouble" },
	})
end

return M
