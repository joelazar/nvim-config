local M = {
	"monaqa/dial.nvim",
}

M.config = function()
	local augend = require("dial.augend")

	require("dial.config").augends:register_group({
		default = {
			augend.integer.alias.decimal_int, -- 100
			augend.integer.alias.hex, -- 0xAB
			augend.date.alias["%Y/%m/%d"], -- 2020/01/01
			augend.date.alias["%Y-%m-%d"], -- 2020-01-01
			augend.constant.alias.bool, -- true
			augend.semver.alias.semver, -- 1.0.1
			augend.date.alias["%m/%d"], -- 12/01
			augend.date.alias["%H:%M"], -- 14:30
		},
		typescript = {
			augend.constant.new({ elements = { "let", "const" } }),
		},
	})
end

M.keys = {
	{
		"<C-a>",
		function()
			return require("dial.map").inc_normal()
		end,
		expr = true,
		desc = "Increment",
	},
	{
		"<C-x>",
		function()
			return require("dial.map").dec_normal()
		end,
		expr = true,
		desc = "Decrement",
	},
}

return M
