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
-- Close buffer
map("n", "<A-c>", ":BufferClose<cr>", opts)
-- Start new line for RETURN
map("n", "<cr>", "o<Esc>", opts)

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
-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-k>", ":m .-2<cr>==", opts)

-- Enhanced increment/decrement
map("n", "<C-a>", require("dial.map").inc_normal(), opts)
map("n", "<C-x>", require("dial.map").dec_normal(), opts)

-- Insert mode

-- 'jk' for quitting insert mode
map("i", "jk", "<ESC>", opts)
-- 'kj' for quitting insert mode
map("i", "kj", "<ESC>", opts)
-- 'jj' for quitting insert mode
map("i", "jj", "<ESC>", opts)

-- Visual mode

-- Search for visually selected text
map("v", "//", 'y/<C-R>"<cr>', opts)
-- Have the same buffer on clipboard for multiple pastes
map("v", "p", "pgvy", opts)

-- Visual block mode

-- Move current line / block with Alt-j/k ala vscode.
map("x", "<A-j>", ":m '>+1<cr>gv-gv", opts)
map("x", "<A-k>", ":m '<-2<cr>gv-gv", opts)

-- Select blocks after indenting
map("x", "<", "<gv", opts)
map("x", ">", ">gv|", opts)

-- Use tab for indenting in visual mode
-- map('x', '<Tab>', ">gv|", opts)
-- map('x', '<S-Tab>', "<gv", opts)

-- Copy to system clipboard
map("x", "\\y", '"+y', opts)

-- Hop keybindings
map(
	"n",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"n",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"o",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"o",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)

-- DAP
map("n", "<F5>", "<cmd>require'dap'.continue<cr>", opts)
map("n", "<F10>", "<cmd>require'dap'.step_over<cr>", opts)
map("n", "<F11>", "<cmd>require'dap'.step_into<cr>", opts)
map("n", "<F12>", "<cmd>require'dap'.step_out<cr>", opts)

-- Make the dot command work as expected in visual mode
-- https://www.reddit.com/r/vim/comments/3y2mgt/
map("v", ".", ":norm .<cr>", opts)

-- quickfix mappings
map("n", "[q", ":cprevious<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
