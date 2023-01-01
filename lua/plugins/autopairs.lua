local M = {
	"windwp/nvim-autopairs",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	event = "VeryLazy",
}

M.config = function()
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	require("nvim-autopairs").setup({
		check_ts = true,
	})
	require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
