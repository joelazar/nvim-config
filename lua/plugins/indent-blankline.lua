local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	config = {
		space_char_blankline = " ",
		buftype_exclude = { "telescope", "terminal", "nofile", "quickfix", "prompt" },
		filetype_exclude = {
			"starter",
			"packer",
			"Trouble",
			"TelescopePrompt",
			"Float",
			"OverseerForm",
			"lspinfo",
			"packer",
			"checkhealth",
			"help",
			"man",
			"",
		},
	},
}

return M
