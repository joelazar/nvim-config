local M = {
	"AckslD/nvim-neoclip.lua",
	event = "VeryLazy",
}

M.config = function()
	require("neoclip").setup({
		enable_persistent_history = false,
		continuous_sync = false,
	})
end

return M
