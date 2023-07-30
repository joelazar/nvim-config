return {
	"rktjmp/paperplanes.nvim",
	opts = {
		register = "+",
		provider = "dpaste.org",
		provider_options = {},
		notifier = vim.notify or print,
	},
	cmd = "PP",
}
