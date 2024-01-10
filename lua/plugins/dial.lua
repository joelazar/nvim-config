return {
	"monaqa/dial.nvim",
	config = function()
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

				-- config specific keywords
				augend.constant.new({ elements = { "enable", "disable" }, word = true, cyclic = true }),
				augend.constant.new({
					elements = { "debug", "info", "notice", "warning", "error", "crit", "alert", "emerg" },
					word = true,
					cyclic = true,
				}),
				-- python specific keywords
				augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
				-- typescript specific keywords
				augend.constant.new({ elements = { "asc", "desc" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "let", "const" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "forEach", "map" }, word = true, cyclic = true }),
			},
		})
	end,
  -- stylua: ignore
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
  },
}
