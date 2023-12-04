local M = {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
}

M.config = function()
	require("todo-comments").setup({
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		keywords = {
			FIX = {
				color = "error",
				alt = { "fix", "FIXME", "BUG", "fixme", "bug" },
			},
			TODO = { color = "info", alt = { "todo" } },
			HACK = { color = "warning", alt = { "hack" } },
			WARN = { color = "warning", alt = { "warn" } },
			PERF = { alt = { "perf" } },
			NOTE = { color = "hint", alt = { "note", "INFO", "info" } },
			TEST = { color = "test", alt = { "test" } },
		},
		gui_style = {
			fg = "NONE", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		highlight = {
			multiline = true, -- enable multine todo comments
			multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
			multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
			before = "", -- "fg" or "bg" or empty
			keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			-- pattern = [[.*<(\iKEYWORDS)\s*\(:\|-\)]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = { "txt", "man", "markdown" }, -- list of file types to exclude highlighting
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--ignore-case",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	})
end

return M
