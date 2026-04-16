return {
  {
    dir = "/Users/joelazar/Code/joelazar/pi-review.nvim",
    name = "pi-review.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>rc",
        "<cmd>PiReviewComment<cr>",
        mode = "n",
        desc = "Pi Review Comment",
      },
      {
        "<leader>rc",
        ":PiReviewComment<cr>",
        mode = "x",
        desc = "Pi Review Comment Range",
      },
      {
        "<leader>rf",
        "<cmd>PiReviewFileComment<cr>",
        desc = "Pi Review File Comment",
      },
      {
        "<leader>rt",
        "<cmd>PiReviewToggle<cr>",
        desc = "Pi Review Toggle",
      },
      {
        "<leader>rd",
        "<cmd>PiReviewDelete<cr>",
        desc = "Pi Review Delete",
      },
      {
        "<leader>rl",
        "<cmd>PiReviewList<cr>",
        desc = "Pi Review List",
      },
      {
        "<leader>re",
        "<cmd>PiReviewExport<cr>",
        desc = "Pi Review Export",
      },
    },
  },
}
