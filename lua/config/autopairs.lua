local M = {}

M.setup = function()
	local present1, autopairs = pcall(require, "nvim-autopairs")
	local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	local present3, cmp = pcall(require, "cmp")

	if present1 and present2 and present3 then
		autopairs.setup({
			fast_wrap = {},
			enable_check_bracket_line = true,
			check_ts = true,
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end
end

return M
