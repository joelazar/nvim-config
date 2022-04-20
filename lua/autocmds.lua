local vimrc_group = vim.api.nvim_create_augroup("vimrc", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	desc = "Hide cursorline in insert mode",
	pattern = "*",
	command = "set nocul",
	group = vimrc_group,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Show cursorline when leaving insert mode",
	pattern = "*",
	command = "set cul",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "CmdlineLeave" }, {
	desc = "show cursor line only in active window",
	pattern = "*",
	command = "set cursorline",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "CmdlineEnter" }, {
	desc = "hide cursor line only in inactive window",
	pattern = "*",
	command = "set nocursorline",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at same location where it was opened last time",
	pattern = "*",
	command = 'if expand(\'%:p\') !~# \'\\m/\\.git/\' && line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif',
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Autoformat before save",
	pattern = { "*.go", "*.js", "*.ts", "*.tsx", "*.lua", "*.yml", "*.json", "*.prisma" },
	callback = vim.lsp.buf.formatting_seq_sync,
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Don't auto commenting new lines",
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Don't show any numbers inside terminals",
	pattern = "term://*",
	command = "setlocal signcolumn=no nonumber norelativenumber | setfiletype terminal",
	group = vimrc_group,
})

local highlight_group = vim.api.nvim_create_augroup("Highlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
	end,
	group = highlight_group,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	desc = "Lightbulb autocmd",
	pattern = "*",
	callback = require("nvim-lightbulb").update_lightbulb,
	group = highlight_group,
})
