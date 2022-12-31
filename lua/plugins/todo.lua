local M = {}

M.config = {
	keywords = {
		FIX = {
			icon = " ",
			color = "error",
			alt = { "fix", "FIXME", "BUG", "fixme", "bug" },
		},
		TODO = { icon = " ", color = "info", alt = { "todo" } },
		HACK = { icon = " ", color = "warning", alt = { "hack" } },
		WARN = { icon = " ", color = "warning", alt = { "warn" } },
		PERF = { icon = " ", alt = { "perf" } },
		NOTE = { icon = " ", color = "hint", alt = { "note", "INFO", "info" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "test" } },
	},

	highlight = {
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
}

M.setup = function()
	local status_ok, todo_comments = pcall(require, "todo-comments")
	if not status_ok then
		return
	end
	todo_comments.setup(M.config)
end

return M
