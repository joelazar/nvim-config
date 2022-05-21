local M = {}

M.setup = function()
	local present, wilder = pcall(require, "wilder")
	if not present then
		return
	end
	wilder.setup({ modes = { ":", "/", "?" } })
	local gradient = {
		"#f4468f",
		"#fd4a85",
		"#ff507a",
		"#ff566f",
		"#ff5e63",
		"#ff6658",
		"#ff704e",
		"#ff7a45",
		"#ff843d",
		"#ff9036",
		"#f89b31",
		"#efa72f",
		"#e6b32e",
		"#dcbe30",
		"#d2c934",
		"#c8d43a",
		"#bfde43",
		"#b6e84e",
		"#aff05b",
	}

	for i, fg in ipairs(gradient) do
		gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
	end

	wilder.set_option(
		"renderer",
		wilder.popupmenu_renderer({
			highlights = {
				gradient = gradient,
			},
			highlighter = wilder.highlighter_with_gradient({
				wilder.basic_highlighter(),
			}),
			pumblend = 20,
			left = { " ", wilder.popupmenu_devicons() },
			right = { " ", wilder.popupmenu_scrollbar() },
		})
	)
	wilder.set_option("pipeline", {
		wilder.branch(
			wilder.python_file_finder_pipeline({
				file_command = { "fd", "-tf" },
				dir_command = { "fd", "-td" },
				filters = { "fuzzy_filter", "difflib_sorter" },
			}),
			wilder.cmdline_pipeline(),
			wilder.python_search_pipeline()
		),
	})
end

return M
