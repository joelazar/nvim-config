-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Only run Prettier when a prettier config file is present (avoid conflicts with Biome)
vim.g.lazyvim_prettier_needs_config = true

-- Show absolute line number in front of each line
vim.o.relativenumber = false

-- Do not use system clipboard
vim.o.clipboard = ""

-- Disable horizontal scrolling
vim.o.mousescroll = "ver:1,hor:0"

vim.o.guicursor = "n-v-c-sm:block-blinkon0,i-ci-ve:ver25-blinkon0,r-cr-o:hor20-blinkon0,t:block-blinkon0-TermCursor"

-- Snacks animations
vim.g.snacks_animate = false

-- Native inline completions don't support being shown as regular completions
vim.g.ai_cmp = true

-- Set to `true` in your `options.lua` to enable experimental support for Next Edit Suggestions
vim.g.copilot_nes = true

-- Global border for all floating windows
vim.o.winborder = "rounded"

-- Disable unused language providers (no remote/rplugin dependencies)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
