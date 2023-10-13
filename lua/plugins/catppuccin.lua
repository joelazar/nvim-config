return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		integrations = {
			barbar = true,
			cmp = true,
			dap = {
				enabled = true,
				enable_ui = true, -- enable nvim-dap-ui
			},
			flash = true,
			gitsigns = true,
			indent_blankline = { enabled = true },
			lsp_trouble = true,
			lualine = true,
			markdown = true,
			mason = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			neotest = true,
			noice = true,
			notify = true,
			octo = true,
			overseer = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
			ts_rainbow2 = true,
			which_key = true,
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
