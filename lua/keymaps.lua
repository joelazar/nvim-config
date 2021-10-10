local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Normal mode

-- Move to previous/next
map('n', '<A-Left>', ':BufferPrevious<cr>', opts)
map('n', '<A-Right>', ':BufferNext<cr>', opts)
-- Re-order to previous/next
map('n', '<A-,>', ':BufferMovePrevious<cr>', opts)
map('n', '<A-.>', ' :BufferMoveNext<cr>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<cr>', opts)
map('n', '<A-2>', ':BufferGoto 2<cr>', opts)
map('n', '<A-3>', ':BufferGoto 3<cr>', opts)
map('n', '<A-4>', ':BufferGoto 4<cr>', opts)
map('n', '<A-5>', ':BufferGoto 5<cr>', opts)
map('n', '<A-6>', ':BufferGoto 6<cr>', opts)
map('n', '<A-7>', ':BufferGoto 7<cr>', opts)
map('n', '<A-8>', ':BufferGoto 8<cr>', opts)
map('n', '<A-9>', ':BufferGoto 9<cr>', opts)
map('n', '<A-0>', ':BufferLast<cr>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<cr>', opts)
-- Add new line below
map('n', 'oo', 'o<Esc>k', opts)
-- Add new line above
map('n', 'OO', 'O<Esc>j', opts)
-- Start new line for RETURN
map('n', '<cr>', 'o<Esc>', opts)

-- Close windows
map('n', 'q', ':close<cr>', opts)

-- Telescope select files
map('n', '<C-p>', '<cmd>Telescope find_files<cr>', opts)

-- Resize with arrows
map('n', '<C-Up>', ':resize -2<cr>', opts)
map('n', '<C-Down>', ':resize +2<cr>', opts)
map('n', '<C-Left>', ':vertical resize -2<cr>', opts)
map('n', '<C-Right>', ':vertical resize +2<cr>', opts)

-- Move current line / block with Alt-j/k ala vscode.
map('n', '<A-j>', ':m .+1<cr>==', opts)
-- Move current line / block with Alt-j/k ala vscode.
map('n', '<A-k>', ':m .-2<cr>==', opts)

-- Insert mode

-- 'jk' for quitting insert mode
map('i', 'jk', '<ESC>', opts)
-- 'kj' for quitting insert mode
map('i', 'kj', '<ESC>', opts)
-- 'jj' for quitting insert mode
map('i', 'jj', '<ESC>', opts)

-- Move current line / block with Alt-j/k ala vscode.
map('i', '<A-j>', '<Esc>:m .+1<cr>==gi', opts)
-- Move current line / block with Alt-j/k ala vscode.
map('i', '<A-k>', '<Esc>:m .-2<cr>==gi', opts)

-- Visual mode

-- Search for visually selected text
map('v', '//', 'y/<C-R>"<cr>', opts)
-- Have the same buffer on clipboard for multiple pastes
map('v', 'p', 'pgvy', opts)

-- Visual block mode

-- Move current line / block with Alt-j/k ala vscode.
map('x', '<A-j>', ":m '>+1<cr>gv-gv", opts)
map('x', '<A-k>', ":m '<-2<cr>gv-gv", opts)

-- Select blocks after indenting
map('x', '<', "<gv", opts)
map('x', '>', ">gv|", opts)

-- Use tab for indenting in visual mode
map('x', '<Tab>', ">gv|", opts)
map('x', '<S-Tab>', "<gv", opts)

-- Single </> should be enough for indenting
-- map('n', '>', ">>_", opts)
-- map('n', '<', "<<_", opts)

map('c', 'W', "<esc>:lua require'utils'.sudo_write()<cr>", {silent = true})
