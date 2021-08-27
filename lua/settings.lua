-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Disable highlight on search
vim.o.hlsearch = false
-- highlight match while typing search pattern
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

-- Enable break indent
vim.o.breakindent = true

-- Use swapfiles
vim.o.swapfile = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 1000

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd [[colorscheme doom-one]]

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

-- From SpaceVim

-- Take indent for new line from previous line
vim.o.autoindent = true
vim.o.smartindent = true

-- GUI: Name(s) of font(s) to be used
vim.o.guifont = "Hack Nerd Font:h20"

-- Number of command-lines that are remembered
vim.o.history = 10000

-- Use menu for command line completion
vim.o.wildmenu = true

-- Wrap long lines at a blank
vim.o.linebreak = true

-- Autom. read file when changed outside of Vim
vim.o.autoread = true

-- Keep backup file after overwriting a file
vim.o.backup = true

-- Make a backup before overwriting a file
vim.o.writebackup = false

-- show cursor line and column in the status line
vim.o.ruler = true

-- Briefly jump to matching bracket if insert one
vim.o.showmatch = true

-- Message on status line to show current mode
vim.o.showmode = true

-- Show relative line number in front of each line
vim.o.relativenumber = true

--  Maximum height of the popup menu
vim.o.pumheight = 15

-- Minimum nr. of lines above and below cursor
vim.o.scrolloff = 5 -- could be 1
vim.o.sidescrolloff = 5
-- vim.o.display = 'lastline'

-- Ignore case when completing file names and directories.
vim.o.wildignorecase = true

-- Timeout on leaderkey
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

-- Show (partial) command in status line
vim.o.showcmd = false

-- Set directories for backup/swap/undo files and create them if necessary
local Path = require "plenary.path"

local swapdir = Path:new(Path.path.home .. '/.cache/nvim/swap/')
if not swapdir:exists() then swapdir:mkdir() end
vim.o.directory = tostring(swapdir)

local backupdir = Path:new(Path.path.home .. '/.cache/nvim/backup/')
if not backupdir:exists() then backupdir:mkdir() end
vim.o.backupdir = tostring(backupdir)

local undodir = Path:new(Path.path.home .. '/.cache/nvim/undo/')
if not undodir:exists() then undodir:mkdir() end
vim.o.undodir = tostring(undodir)
