return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		space_char_blankline = " ",
		buftype_exclude = { "telescope", "terminal", "nofile", "quickfix", "prompt" },
		filetype_exclude = {
			"starter",
			"Trouble",
			"TelescopePrompt",
			"Float",
			"OverseerForm",
			"lspinfo",
			"checkhealth",
			"help",
			"man",
			"",
		},
	},
}
