local function augroup(name)
	return vim.api.nvim_create_augroup("vimrc_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check if we need to reload the file when it changed",
	command = "checktime",
	group = augroup("checktime"),
})

vim.api.nvim_create_autocmd("InsertEnter", {
	desc = "Hide cursorline in insert mode",
	pattern = "*",
	command = "set nocul",
	group = augroup("cursorline_hide_insert"),
})

vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Show cursorline when leaving insert mode",
	pattern = "*",
	command = "set cul",
	group = augroup("cursorline_show_insert"),
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "CmdlineLeave" }, {
	desc = "Show cursorline only in active window",
	pattern = "*",
	command = "set cursorline",
	group = augroup("cursorline_show_active"),
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "CmdlineEnter" }, {
	desc = "Hide cursorline only in inactive window",
	pattern = "*",
	command = "set nocursorline",
	group = augroup("cursorline_hide_inactive"),
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at same location where it was opened last time",
	callback = function()
		vim.cmd([[silent! normal! g`"]])
	end,
	group = augroup("cursorline_hide_inactive"),
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Go to last loc when opening a buffer",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	group = augroup("last_loc"),
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Don't show any numbers inside terminals",
	pattern = "term://*",
	command = "setlocal signcolumn=no nonumber norelativenumber | setfiletype terminal",
	group = augroup("terminal_no_numbers"),
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
	end,
	group = augroup("highlight_yank"),
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Create directories when needed, when saving a file",
	command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
	group = augroup("auto_create_dir"),
})

vim.api.nvim_create_autocmd("TermClose", {
	desc = "Close terminals automatically at exit",
	pattern = "term://*",
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_input("<CR>")
		end
	end,
	group = augroup("terminal_close_at_exit"),
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Resize splits if window got resized",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
	group = augroup("resize_splits"),
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Close some filetypes with <q>",
	pattern = {
		"PlenaryTestPopup",
		"TelescopePrompt",
		"chatgpt",
		"checkhealth",
		"dap-repl",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close!<cr>", { buffer = event.buf, silent = true })
	end,
	group = augroup("close_with_q"),
})
