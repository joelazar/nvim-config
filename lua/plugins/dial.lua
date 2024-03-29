local M = {}
---@type table<string, table<string, string[]>>
M.dials_by_ft = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
	local is_visual = vim.fn.mode(true):sub(1, 1) == "v"
	local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
	local group = M.dials_by_ft[vim.bo.filetype] or "default"
	return require("dial.map")[func](group)
end

return {
	"monaqa/dial.nvim",
	opts = function()
		local augend = require("dial.augend")

		local ordinal_numbers = augend.constant.new({
			elements = {
				"first",
				"second",
				"third",
				"fourth",
				"fifth",
				"sixth",
				"seventh",
				"eighth",
				"ninth",
				"tenth",
			},
			word = false,
			cyclic = true,
		})
		local weekdays = augend.constant.new({
			elements = {
				"Monday",
				"Tuesday",
				"Wednesday",
				"Thursday",
				"Friday",
				"Saturday",
				"Sunday",
			},
			word = true,
			cyclic = true,
		})
		local months = augend.constant.new({
			elements = {
				"January",
				"February",
				"March",
				"April",
				"May",
				"June",
				"July",
				"August",
				"September",
				"October",
				"November",
				"December",
			},
			word = true,
			cyclic = true,
		})

		return {
			dials_by_ft = {
				css = "css",
				javascript = "typescript",
				javascriptreact = "typescript",
				json = "json",
				lua = "lua",
				markdown = "markdown",
				python = "python",
				sass = "css",
				scss = "css",
				typescript = "typescript",
				typescriptreact = "typescript",
			},
			groups = {
				default = {
					augend.integer.alias.decimal_int, -- 100
					augend.integer.alias.hex, -- 0xAB
					augend.date.alias["%Y/%m/%d"], -- 2020/01/01
					augend.date.alias["%Y-%m-%d"], -- 2020-01-01
					augend.constant.alias.bool, -- true
					augend.semver.alias.semver, -- 1.0.1
					augend.date.alias["%m/%d"], -- 12/01
					augend.date.alias["%H:%M"], -- 14:30
					ordinal_numbers,
					weekdays,
					months,

					-- config specific keywords
					augend.constant.new({ elements = { "enable", "disable" } }),
					augend.constant.new({
						elements = { "debug", "info", "notice", "warning", "error", "crit", "alert", "emerg" },
						word = true,
						cyclic = true,
					}),
				},
				typescript = {
					augend.constant.new({ elements = { "&&", "||" } }),
					augend.constant.new({ elements = { "let", "const" } }),
					augend.constant.new({ elements = { "asc", "desc" } }),
					augend.constant.new({ elements = { "forEach", "map" } }),
				},
				css = {
					augend.hexcolor.new({ case = "lower" }),
					augend.hexcolor.new({ case = "upper" }),
				},
				markdown = {
					augend.misc.alias.markdown_header,
				},
				lua = { -- or
					augend.constant.new({ elements = { "and", "or" } }),
				},
				python = {
					augend.constant.new({ elements = { "and", "or" } }),
					augend.constant.new({ elements = { "True", "False" } }),
				},
			},
		}
	end,
	config = function(_, opts)
		require("dial.config").augends:register_group(opts.groups)
		M.dials_by_ft = opts.dials_by_ft
	end,
	-- stylua: ignore
	keys = {
		{ "<C-a>", function() return M.dial(true) end,  expr = true, desc = "Increment", mode = { "n", "v" } },
		{ "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = { "n", "v" } },
	},
}
