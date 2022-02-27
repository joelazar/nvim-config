local M = {}

M.setup = function()
	local project_ok, project_nvim = pcall(require, "project_nvim")
	if not project_ok then
		return
	end
	local telescope_ok, telescope = pcall(require, "telescope")
	if not telescope_ok then
		return
	end

	project_nvim.setup({
		manual_mode = false,
		detection_methods = { "pattern" },
		patterns = { ".git" },
		ignore_lsp = {},
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		datapath = vim.fn.stdpath("data"),
	})
	telescope.load_extension("projects")
end

return M
