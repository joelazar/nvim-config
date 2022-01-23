-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = "nosplit"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Enable highlight on search
vim.o.hlsearch = true
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
vim.wo.signcolumn = "yes"

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[ colorscheme nightfox ]])

-- Disable intro message
vim.opt.shortmess:append("I")

-- Disable ins-completion-menu messages
vim.opt.shortmess:append("c")

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)

-- Don't auto commenting new lines
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- Don't show any numbers inside terminals
vim.cmd([[ au TermOpen term://* setlocal signcolumn=no nonumber norelativenumber | setfiletype terminal ]])

-- Take indent for new line from previous line
vim.o.autoindent = true
vim.o.smartindent = true

-- GUI: Name(s) of font(s) to be used
vim.o.guifont = "Roboto Mono:h27"

-- Neovide config
vim.g.neovide_cursor_animation_length = 0.0
vim.g.neovide_cursor_trail_length = 0.0

-- Number of command-lines that are remembered
vim.o.history = 10000

-- Use menu for command line completion
vim.o.wildmenu = true

-- Enable wrap
vim.o.wrap = true

-- Wrap long lines at a blank
vim.o.linebreak = true

-- Autom. read file when changed outside of Vim
vim.o.autoread = true

-- Autom. save file before some action
vim.o.autowrite = true

-- Keep backup file after overwriting a file
vim.o.backup = true

-- Make a backup before overwriting a file
vim.o.writebackup = false

-- Show cursor line and column in the status line
vim.o.ruler = true

-- Briefly jump to matching bracket if insert one
vim.o.showmatch = true

-- Hide show current mode on status line
vim.o.showmode = false

-- Show relative line number in front of each line
vim.o.relativenumber = true

-- Disable python2 provider
vim.g.loaded_python_provider = 0

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
vim.o.ttimeoutlen = 5

-- Timeout on mapped sequences
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Show (partial) command in status line
vim.o.showcmd = false

-- Folding
vim.o.foldenable = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Asyncrun automatically open quickfix window
vim.g.asyncrun_open = 6

-- go - format on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_seq_sync() ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('config.go').goimport() ]], false)

-- Open file at same location where it was opened last time
vim.cmd(
	[[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
)

-- Set directories for backup/swap/undo files and create them if necessary
local Path = require("plenary.path")

local swapdir = Path:new(Path.path.home .. "/.cache/nvim/swap/")
if not swapdir:exists() then
	swapdir:mkdir()
end
vim.o.directory = tostring(swapdir)

local backupdir = Path:new(Path.path.home .. "/.cache/nvim/backup/")
if not backupdir:exists() then
	backupdir:mkdir()
end
vim.o.backupdir = tostring(backupdir)

local undodir = Path:new(Path.path.home .. "/.cache/nvim/undo/")
if not undodir:exists() then
	undodir:mkdir()
end
vim.o.undodir = tostring(undodir)

-- disable some builtin vim plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
