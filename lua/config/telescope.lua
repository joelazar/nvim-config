local M = {}

M.config = {
	defaults = {
		path_display = { truncate = 3 },
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<S-Up>"] = require("telescope.actions").preview_scrolling_up,
				["<S-Down>"] = require("telescope.actions").preview_scrolling_down,
				["<PageDown>"] = require("telescope.actions").cycle_history_next,
				["<PageUp>"] = require("telescope.actions").cycle_history_prev,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--trim",
			"--glob=!.git/",
			"--glob=!package-lock.json",
		},
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		scroll_strategy = "cycle",
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "bottom",
			horizontal = { preview_width = 0.6, results_width = 0.8 },
			width = 0.95,
			height = 0.95,
			preview_cutoff = 120,
		},
		file_ignore_patterns = { "node_modules", "^.git/" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- preview = {
		-- 	check_mime_type = true,
		-- 	filesize_limit = 0.5,
		-- 	timeout = 200,
		-- 	treesitter = true,
		-- 	msg_bg_fillchar = "╱",
		-- },
	},
	pickers = { find_files = { hidden = true } },
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
}

M.grep_string_visual = function()
	local builtin = require("telescope.builtin")
	local visual_selection = function()
		local save_previous = vim.fn.getreg("a")
		vim.api.nvim_command('silent! normal! "ay')
		local selection = vim.fn.trim(vim.fn.getreg("a"))
		vim.fn.setreg("a", save_previous)
		return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
	end
	builtin.live_grep({
		default_text = visual_selection(),
	})
end

M.setup = function()
	local status_ok, telescope = pcall(require, "telescope")
	if not status_ok then
		return
	end
	telescope.setup(M.config)
	telescope.load_extension("file_browser")
	telescope.load_extension("octo")
	telescope.load_extension("live_grep_args")
end

return M
