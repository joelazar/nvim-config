-- Buffer line configuration
-- Shows open buffers at the top of the screen
return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
  keys = {
    { "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Move to previous buffer" },
    { "<A-Right>", "<cmd>BufferLineCycleNext<cr>", desc = "Move to next buffer" },
    { "<A-,>", "<cmd>BufferLineMovePrev<cr>", desc = "Re-order to previous buffer" },
    { "<A-.>", "<cmd>BufferLineMoveNext<cr>", desc = "Re-order to next buffer" },
    { "<A-p>", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
    { "<leader>bP", false },
    { "<leader>bw", "<Cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bW", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete All Buffers" },
  },
}

