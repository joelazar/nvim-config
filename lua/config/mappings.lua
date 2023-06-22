local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode

-- Move to previous/next
map("n", "<A-Left>", "<cmd>BufferPrevious<cr>", opts)
map("n", "<A-Right>", "<cmd>BufferNext<cr>", opts)

-- Re-order to previous/next
map("n", "<A-,>", "<cmd>BufferMovePrevious<cr>", opts)
map("n", "<A-.>", "<cmd>BufferMoveNext<cr>", opts)

-- Goto buffer in position...
map("n", "<A-1>", "<cmd>BufferGoto 1<cr>", opts)
map("n", "<A-2>", "<cmd>BufferGoto 2<cr>", opts)
map("n", "<A-3>", "<cmd>BufferGoto 3<cr>", opts)
map("n", "<A-4>", "<cmd>BufferGoto 4<cr>", opts)
map("n", "<A-5>", "<cmd>BufferGoto 5<cr>", opts)
map("n", "<A-6>", "<cmd>BufferGoto 6<cr>", opts)
map("n", "<A-7>", "<cmd>BufferGoto 7<cr>", opts)
map("n", "<A-8>", "<cmd>BufferGoto 8<cr>", opts)
map("n", "<A-9>", "<cmd>BufferGoto 9<cr>", opts)
map("n", "<A-0>", "<cmd>BufferLast<cr>", opts)

-- Pin buffer
map("n", "<A-p>", "<cmd>BufferPin<cr>", opts)

-- Close buffer
map("n", "<A-c>", "<cmd>BufferClose<cr>", opts)

-- Close windows
map("n", "Q", "<cmd>close<cr>", opts)

-- Telescope select files
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Stay centered jumping between search results
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Fix cursor position after joining lines
map("n", "J", "mzJ`z", opts)

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Insert mode

-- Ctrl+V for pasting from system clipboard
map("i", "<c-v>", "<c-r>+", opts)

-- Visual mode

-- Search for visually selected text
map("v", "//", 'y/<C-R>"<cr>', opts)

-- Have the same buffer on clipboard for multiple pastes
map("v", "p", "pgvy", opts)

-- Visual block mode

-- Use tab for indenting in visual mode
map("x", "<Tab>", ">gv|", opts)
map("x", "<S-Tab>", "<gv", opts)

-- Delete to blackhole register
map({ "n", "x" }, "\\d", '"_d', { desc = "Delete to blackhole register" })

-- DAP
map("n", "<F5>", "<cmd>require'dap'.continue<cr>", opts)
map("n", "<F10>", "<cmd>require'dap'.step_over<cr>", opts)
map("n", "<F11>", "<cmd>require'dap'.step_into<cr>", opts)
map("n", "<F12>", "<cmd>require'dap'.step_out<cr>", opts)

-- Make the dot command work as expected in visual mode
-- https://www.reddit.com/r/vim/comments/3y2mgt/
map("v", ".", "<cmd>norm .<cr>", opts)

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

map("n", "<C-q>", "<cmd>call QuickFixToggle()<cr>", opts)
map("n", "<C-`>", "<cmd>ToggleTerm<cr>", opts)

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
-- swapping buffers between windows
vim.keymap.set("n", "<C-A-h>", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<C-A-j>", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<C-A-k>", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<C-A-l>", require("smart-splits").swap_buf_right)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

vim.api.nvim_create_user_command("OverseerRestartLast", function()
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ recent_first = true })
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], "restart")
	end
end, {})

vim.api.nvim_create_user_command("TSReload", function()
	vim.cmd([[
      write
      edit
      TSBufEnable highlight
  ]])
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
