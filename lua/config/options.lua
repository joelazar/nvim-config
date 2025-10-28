-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Show absolute line number in front of each line
vim.o.relativenumber = false

-- Do not use system clipboard
vim.o.clipboard = ""

-- Disable horizontal scrolling
vim.o.mousescroll = "ver:1,hor:0"

-- Snacks animations
vim.g.snacks_animate = false

-- Native inline completions don't support being shown as regular completions
vim.g.ai_cmp = true

-- Set to `true` in your `options.lua` to enable experimental support for Next Edit Suggestions
vim.g.copilot_nes = true
