return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        split = {
          width = 0.4,
        },
      },
      -- mux = {
      --   backend = "tmux",
      --   enabled = true,
      -- },
      tools = {
        claude = { cmd = { "claude", "--dangerously-skip-permissions" } },
        gemini = { cmd = { "gemini", "--yolo" } },
      },
    },
  },
  keys = {
    {
      "<D-r>",
      function()
        require("sidekick.cli").toggle("pi")
      end,
      desc = "Toggle AI window",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<D-e>",
      function()
        local win = vim.api.nvim_get_current_win()
        local width = vim.api.nvim_win_get_width(win)
        local total = vim.o.columns
        if width > total * 0.8 then
          -- Restore to 40%
          vim.api.nvim_win_set_width(win, math.floor(total * 0.4))
        else
          -- Maximize
          vim.api.nvim_win_set_width(win, math.floor(total * 0.95))
        end
      end,
      desc = "Toggle maximize window",
      mode = { "n", "t", "i", "x" },
    },
  },
}
