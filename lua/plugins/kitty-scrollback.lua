return {
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = true,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	config = function()
		require("kitty-scrollback").setup()
		vim.keymap.set({ "v" }, "\\Y", "<Plug>(KsbVisualYankLine)", {})
		vim.keymap.set({ "v" }, "\\y", "<Plug>(KsbVisualYank)", {})
		vim.keymap.set({ "n" }, "\\Y", "<Plug>(KsbNormalYankEnd)", {})
		vim.keymap.set({ "n" }, "\\y", "<Plug>(KsbNormalYank)", {})
		vim.keymap.set({ "n" }, "\\yy", "<Plug>(KsbYankLine)", {})
	end,
}
