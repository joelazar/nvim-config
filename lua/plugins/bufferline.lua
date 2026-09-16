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
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Workaround: bufferline keeps pinned buffer ids in its manual_groupings
    -- table even after the buffer is wiped out (e.g. via Snacks.bufdelete).
    -- persist_pinned_buffers then calls nvim_buf_get_name on the dead id and
    -- errors with "Invalid buffer id" on the next BufferLineTogglePin.
    vim.api.nvim_create_autocmd("BufWipeout", {
      group = vim.api.nvim_create_augroup("bufferline_pin_cleanup", { clear = true }),
      callback = function(ev)
        require("bufferline.groups").remove_id_from_manual_groupings(ev.buf)
      end,
    })
  end,
  keys = {
    { "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Move to previous buffer" },
    { "<A-Right>", "<cmd>BufferLineCycleNext<cr>", desc = "Move to next buffer" },
    { "<A-,>", "<cmd>BufferLineMovePrev<cr>", desc = "Re-order to previous buffer" },
    { "<A-.>", "<cmd>BufferLineMoveNext<cr>", desc = "Re-order to next buffer" },
    { "<A-p>", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
    { "<leader>bP", false },
    {
      "<leader>bw",
      function()
        -- BufferLineGroupClose bypasses close_command and uses a raw bdelete!,
        -- which closes the window showing the buffer (e.g. when focused on the
        -- explorer sidebar). Use Snacks.bufdelete so windows keep a buffer.
        local groups = require("bufferline.groups")
        Snacks.bufdelete({
          filter = function(buf)
            return not groups._is_pinned({ id = buf })
          end,
        })
      end,
      desc = "Delete Non-Pinned Buffers",
    },
    { "<leader>bW", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete All Buffers" },
  },
}
