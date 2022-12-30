local M = {}

M.setup = function()
	local status_ok, dressing = pcall(require, "dressing")
	if not status_ok then
		return
	end
	dressing.setup({
		input = {
			mappings = {
				n = {
					q = "Close",
				},
			},
			default_prompt = "➤ ",
		},
		select = {
			backend = { "telescope" },
			telescope = require("telescope.themes").get_ivy({
				sorting_strategy = "descending",
				layout_config = {
					height = 12,
				},
			}),
			mappings = {
				n = {
					q = "Close",
				},
			},
		},
	})
end

return M
