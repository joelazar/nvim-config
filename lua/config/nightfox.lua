local M = {}

M.config = {
	fox = "nightfox",
	styles = {
		comments = "italic",
		keywords = "bold",
		functions = "bold",
		strings = "italic",
		variables = "NONE",
	},
	-- inverse = {
	-- 	match_paren = true, -- inverse the highlighting of match_parens
	-- },
}

M.setup = function()
	local status_ok, nightfox = pcall(require, "nightfox")
	if not status_ok then
		return
	end
	nightfox.setup(M.config)
	nightfox.load()
end

return M
