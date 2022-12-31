local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Normal mode

-- Move to previous/next
map("n", "<A-Left>", ":BufferPrevious<cr>", opts)
map("n", "<A-Right>", ":BufferNext<cr>", opts)

-- Re-order to previous/next
map("n", "<A-,>", ":BufferMovePrevious<cr>", opts)
map("n", "<A-.>", " :BufferMoveNext<cr>", opts)

-- Goto buffer in position...
map("n", "<A-1>", ":BufferGoto 1<cr>", opts)
map("n", "<A-2>", ":BufferGoto 2<cr>", opts)
map("n", "<A-3>", ":BufferGoto 3<cr>", opts)
map("n", "<A-4>", ":BufferGoto 4<cr>", opts)
map("n", "<A-5>", ":BufferGoto 5<cr>", opts)
map("n", "<A-6>", ":BufferGoto 6<cr>", opts)
map("n", "<A-7>", ":BufferGoto 7<cr>", opts)
map("n", "<A-8>", ":BufferGoto 8<cr>", opts)
map("n", "<A-9>", ":BufferGoto 9<cr>", opts)
map("n", "<A-0>", ":BufferLast<cr>", opts)

-- Pin buffer
map("n", "<A-p>", ":BufferPin<cr>", opts)

-- Close buffer
map("n", "<A-c>", ":BufferClose<cr>", opts)

-- Close windows
map("n", "Q", ":close<cr>", opts)

-- Telescope select files
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<cr>", opts)
map("n", "<C-Down>", ":resize -2<cr>", opts)
map("n", "<C-Left>", ":vertical resize +2<cr>", opts)
map("n", "<C-Right>", ":vertical resize -2<cr>", opts)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-j>", ":m .+1<cr>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", opts)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-k>", ":m .-2<cr>==", opts)
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", opts)

-- Enhanced increment/decrement
map("n", "<C-a>", require("dial.map").inc_normal(), opts)
map("n", "<C-x>", require("dial.map").dec_normal(), opts)

-- Stay centered jumping between search results
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Fix cursor position after joining lines
map("n", "J", "mzJ`z", opts)

-- clear any highlights when <esc> is pressed
map("n", "<Esc>", ":noh<cr>", opts)

-- move one up/down display line instead of physicial line
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Insert mode

-- 'jk' for quitting insert mode
map("i", "jk", "<ESC>", opts)

-- 'kj' for quitting insert mode
map("i", "kj", "<ESC>", opts)

-- 'jj' for quitting insert mode
map("i", "jj", "<ESC>", opts)

-- Ctrl+V for pasting from system clipboard
map("i", "<c-v>", "<c-r>+", opts)

-- Visual mode

-- Search for visually selected text
map("v", "//", 'y/<C-R>"<cr>', opts)

-- Have the same buffer on clipboard for multiple pastes
map("v", "p", "pgvy", opts)

-- Visual block mode

-- Move current line / block with Alt-j/k ala vscode.
map("x", "<A-j>", ":m '>+1<cr>gv-gv", opts)
map("x", "<A-k>", ":m '<-2<cr>gv-gv", opts)

-- Use tab for indenting in visual mode
map("x", "<Tab>", ">gv|", opts)
map("x", "<S-Tab>", "<gv", opts)

-- Copy to system clipboard
map("x", "\\y", '"+y', opts)
map("x", "\\Y", '"*y', opts)

-- Cut to system clipboard
map("x", "\\d", '"+d', opts)
map("x", "\\D", '"*d', opts)

-- Paste from system clipboard
map("n", "\\p", '<ESC>"+p', opts)
map("n", "\\P", '<ESC>"*p', opts)

-- Search and Replace
map("n", "c.", ":%s//g<Left><Left>", opts)
map("n", "\\c.", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", opts)

-- Hop keybindings
map(
	"n",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
	,
	{}
)
map(
	"n",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
	,
	{}
)
map(
	"o",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
	,
	{}
)
map(
	"o",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
	,
	{}
)
map(
	"n",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
	,
	{}
)
map(
	"n",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
	,
	{}
)
map(
	"o",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1, inclusive_jump = true })<cr>"
	,
	{}
)
map(
	"o",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1, inclusive_jump = true })<cr>"
	,
	{}
)
map("", "s", "<cmd>lua require'hop'.hint_char2()<cr>", {})
map("", "S", "<cmd>lua require'hop'.hint_patterns()<cr>", {})
map("", "L", "<cmd>lua require'hop'.hint_lines()<cr>", {})

-- DAP
map("n", "<F5>", "<cmd>require'dap'.continue<cr>", opts)
map("n", "<F10>", "<cmd>require'dap'.step_over<cr>", opts)
map("n", "<F11>", "<cmd>require'dap'.step_into<cr>", opts)
map("n", "<F12>", "<cmd>require'dap'.step_out<cr>", opts)

-- Make the dot command work as expected in visual mode
-- https://www.reddit.com/r/vim/comments/3y2mgt/
map("v", ".", ":norm .<cr>", opts)

-- quickfix mappings
map("n", "[q", ":cprevious<cr>", opts)
map("n", "]q", ":cnext<cr>", opts)
map("n", "]Q", ":clast<cr>", opts)
map("n", "[Q", ":cfirst<cr>", opts)

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

map("n", "<C-q>", ":call QuickFixToggle()<cr>", opts)

-- todo comments mappings
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- gitsigns mappings
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		require("gitsigns").next_hunk()
	end)
	return "<Ignore>"
end, { expr = true })

vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		require("gitsigns").prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

vim.api.nvim_create_user_command("OverseerRestartLast", function()
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ recent_first = true })
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], "restart")
	end
end, {})

-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override you last yank.
-- Code above will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end

vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

local fences = {
	"go",
	"javascript",
	"js=javascript",
	"json",
	"lua",
	"python",
	"sh",
	"shell=sh",
	"ts=typescript",
	"typescript",
}
vim.g.markdown_fenced_languages = fences
