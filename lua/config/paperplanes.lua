local M = {}

M.setup = function()
	local status_ok, paperplanes = pcall(require, "paperplanes")
	if not status_ok then
		return
	end

	paperplanes.setup({
		register = "+",
		provider = "dpaste.org",
		provider_options = {},
		notifier = vim.notify or print,
	})
end

return M
