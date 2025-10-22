return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      tools = {
        claude = { cmd = { "claude", "--dangerously-skip-permissions" } },
        copilot = { cmd = { "copilot", "--allow-all-tools" } },
        gemini = { cmd = { "gemini", "--yolo" } },
        crush = { cmd = { "crush", "--yolo" } },
      },
    },
  },
  keys = {
    {
      "<D-r>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Toggle AI window",
      mode = { "n", "t", "i", "x" },
    },
  },
}
