local M = {}

M.setup = function()
	local surround_ok, surround = pcall(require, "mini.surround")
	if not surround_ok then
		return
	end
	surround.setup({
		-- Number of lines within which surrounding is searched
		n_lines = 20,

		-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
		highlight_duration = 2000,

		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			add = "sa", -- Add surrounding
			delete = "sd", -- Delete surrounding
			find = "sf", -- Find surrounding (to the right)
			find_left = "sF", -- Find surrounding (to the left)
			highlight = "sh", -- Highlight surrounding
			replace = "sr", -- Replace surrounding
			update_n_lines = "sn", -- Update `n_lines`
		},
	})

	local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
	if not trailspace_ok then
		return
	end
	trailspace.setup({
		-- Highlight only in normal buffers (ones with empty 'buftype'). This is
		-- useful to not show trailing whitespace where it usually doesn't matter.
		only_in_normal_buffers = true,
	})
end

return M
