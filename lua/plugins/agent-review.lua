return {
  {
    dir = "/Users/joelazar/Code/joelazar/agent-review.nvim",
    name = "agent-review.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>rc",
        "<cmd>AgentReviewComment<cr>",
        mode = "n",
        desc = "Agent Review Comment",
      },
      {
        "<leader>rc",
        ":AgentReviewComment<cr>",
        mode = "x",
        desc = "Agent Review Comment Range",
      },
      {
        "<leader>rf",
        "<cmd>AgentReviewFileComment<cr>",
        desc = "Agent Review File Comment",
      },
      {
        "<leader>rt",
        "<cmd>AgentReviewToggle<cr>",
        desc = "Agent Review Toggle",
      },
      {
        "<leader>rd",
        "<cmd>AgentReviewDelete<cr>",
        desc = "Agent Review Delete",
      },
      {
        "<leader>rl",
        "<cmd>AgentReviewList<cr>",
        desc = "Agent Review List",
      },
      {
        "<leader>re",
        "<cmd>AgentReviewExport<cr>",
        desc = "Agent Review Export",
      },
    },
  },
}
