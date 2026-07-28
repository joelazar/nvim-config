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

-- Set to `true` in your `options.lua` to enable experimental support for Next Edit Suggestions
vim.g.copilot_nes = true

-- Global border for all floating windows
vim.o.winborder = "rounded"

-- Neovide GUI (startup-only settings live in ~/.config/neovide/config.toml)
if vim.g.neovide then
  vim.o.guifont = "Maple Mono NF:h13"

  -- No animations anywhere
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_smooth_blink = false
  vim.g.neovide_cursor_vfx_mode = ""

  -- Window / input behaviour
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left" -- matches macos-option-as-alt = left
  vim.g.neovide_theme = "dark"
end

-- Disable unused language providers (no remote/rplugin dependencies)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
