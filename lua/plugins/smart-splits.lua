-- Seamless split navigation between Neovim windows and herdr panes.
-- Not lazy-loaded on purpose: the herdr integration needs the plugin present
-- so `<C-h/j/k/l>` forwarded by herdr land in the plugin, not in default vim keys.
--
-- herdr side: `herdr plugin link ~/.local/share/nvim/lazy/smart-splits.nvim`
-- plus the `[[keys.command]]` plugin_action bindings in ~/.config/herdr/config.toml.
return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  -- herdr integration is only on master so far (not in a tagged release)
  version = false,
  opts = {
    ignored_filetypes = { "NvimTree", "neo-tree", "snacks_picker_list", "edgy" },
    ignored_buftypes = { "nofile", "quickfix", "prompt" },
    default_amount = 3,
    -- at the edge of the last Neovim split, cross over into the neighbouring
    -- herdr pane (handled by the mux backend); if there is none, stop.
    at_edge = "stop",
    float_win_behavior = "previous",
    disable_multiplexer_nav_when_zoomed = true,
    multiplexer_integration = vim.env.HERDR_ENV and "herdr" or nil,
  },
  keys = {
    -- move between splits (and herdr panes)
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
