local M = {
	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	ft = "markdown",
}

M.config = function()
	require("peek").setup({
		auto_load = true,
		close_on_bdelete = true,
		syntax = true,
		theme = "dark",
		update_on_change = true,
		throttle_at = 200000,
		throttle_time = "auto",
	})

	vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

return M
