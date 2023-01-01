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
	desc = "Show cursorline only in active window",
	pattern = "*",
	command = "set cursorline",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave", "CmdlineEnter" }, {
	desc = "Hide cursorline only in inactive window",
	pattern = "*",
	command = "set nocursorline",
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at same location where it was opened last time",
	callback = function()
		vim.cmd([[silent! normal! g`"]])
	end,
	group = vimrc_group,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Autoformat before save",
	pattern = { "*.go", "*.js", "*.ts", "*.tsx", "*.lua", "*.yml", "*.json", "*.prisma", "*.py", "*.mjs" },
	callback = function()
		vim.lsp.buf.format()
	end,
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

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Create directories when needed, when saving a file",
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

vim.api.nvim_create_autocmd("TermClose", {
	desc = "Close terminals automatically at exit",
	pattern = "term://*",
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_input("<CR>")
		end
	end,
	group = vimrc_group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Close some filetypes with <q>",
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
	group = vimrc_group,
})
