return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "theHamsta/nvim-dap-virtual-text", enabled = false },
  {
    "igorlfs/nvim-dap-view",
    version = "1.*",
    dependencies = { "mfussenegger/nvim-dap" },
    cmd = { "DapViewOpen", "DapViewClose", "DapViewToggle", "DapViewWatch", "DapViewJump", "DapViewShow" },
    opts = {
      auto_toggle = true,
      virtual_text = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dap-view").toggle() end, desc = "Dap View" },
      { "<leader>de", function() require("dap-view").hover() end, desc = "Eval", mode = { "n", "x" } },
      { "<leader>dW", function() require("dap-view").add_expr() end, desc = "Add Watch", mode = { "n", "x" } },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view" },
  },
}
