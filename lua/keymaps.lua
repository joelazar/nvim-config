local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Normal mode

-- Move to previous/next
map('n', '<A-Left>', ':BufferPrevious<CR>', opts)
map('n', '<A-Right>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-,>', ':BufferMovePrevious<CR>', opts)
map('n', '<A-.>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Add new line below
map('n', 'oo', 'o<Esc>k', opts)
-- Add new line above
map('n', 'OO', 'O<Esc>j', opts)
-- Start new line for RETURN
map('n', '<CR>', 'o<Esc>', opts)

-- Telescope select files
map('n', '<C-p>', '<cmd>Telescope find_files<CR>', opts)

-- Resize with arrows
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Move current line / block with Alt-j/k ala vscode.
map('n', '<A-j>', ':m .+1<CR>==', opts)
-- Move current line / block with Alt-j/k ala vscode.
map('n', '<A-k>', ':m .-2<CR>==', opts)

-- Insert mode

-- 'jk' for quitting insert mode
map('i', 'jk', '<ESC>', opts)
-- 'kj' for quitting insert mode
map('i', 'kj', '<ESC>', opts)
-- 'jj' for quitting insert mode
map('i', 'jj', '<ESC>', opts)

-- Move current line / block with Alt-j/k ala vscode.
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
-- Move current line / block with Alt-j/k ala vscode.
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- Visual mode

-- Search for visually selected text
map('v', '//', 'y/<C-R>"<CR>', opts)
-- Have the same buffer on clipboard for multiple pastes
map('v', 'p', 'pgvy', opts)

-- Visual block mode

-- Move current line / block with Alt-j/k ala vscode.
map('x', '<A-j>', ":m '>+1<CR>gv-gv", opts)
map('x', '<A-k>', ":m '<-2<CR>gv-gv", opts)

