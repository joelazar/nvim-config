-- Seamless split navigation between Neovim windows and Rex panes.
-- Not lazy-loaded on purpose: Rex passes `<C-h/j/k/l>` through to Neovim,
-- so the plugin must be present to catch them instead of default vim keys.
--
-- Rex side: `ctrl+h/j/k/l` bindings in Rex `init.lua` that fall through when
-- Neovim is the foreground process (see smart-splits-backend-rex README).
return {
  "smart-splits-nvim/smart-splits.nvim",
  version = "^3.0.0",
  lazy = false,
  dependencies = {
    { "rawnly/smart-splits-backend-rex", opts = {} },
  },
  opts = {
    ignored_filetypes = { "NvimTree", "neo-tree", "snacks_picker_list", "edgy" },
    ignored_buftypes = { "nofile", "quickfix", "prompt" },
    resize = { amount = 3 },
    -- at the edge of the last Neovim split, cross over into the neighbouring
    -- Rex pane (handled by the mux backend); if there is none, stop.
    move = { at_edge = "stop" },
    mux = { backend = "smart-splits-backend-rex" },
  },
  -- stylua: ignore
  keys = {
    -- move between splits (and Rex panes)
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Go to left window/pane" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Go to lower window/pane" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Go to upper window/pane" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Go to right window/pane" },
    { "<C-\\>", function() require("smart-splits").move_cursor_previous() end, desc = "Go to previous window" },
    -- resize (matches LazyVim's default resize keys)
    { "<C-Left>", function() require("smart-splits").resize_left() end, desc = "Resize window left" },
    { "<C-Down>", function() require("smart-splits").resize_down() end, desc = "Resize window down" },
    { "<C-Up>", function() require("smart-splits").resize_up() end, desc = "Resize window up" },
    { "<C-Right>", function() require("smart-splits").resize_right() end, desc = "Resize window right" },
    -- swap buffers between windows
    { "<leader>wh", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
    { "<leader>wj", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
    { "<leader>wk", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
    { "<leader>wl", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
  },
}
