return {
  "joelazar/sidekick.nvim",
  opts = {
    cli = {
      win = {
        csiu = true,
        split = {
          width = 0.4,
        },
      },
      mux = {
        enabled = true,
        create = "split",
        split = {
          vertical = true,
          size = 0.4,
        },
      },
      tools = {
        claude = { cmd = { "claude", "--dangerously-skip-permissions" } },
        antigravity = {},
      },
    },
  },
  config = function(_, opts)
    require("sidekick").setup(opts)
    require("sidekick.config").cli.tools.gemini = nil
  end,
  keys = {
    {
      "<D-r>",
      function()
        require("sidekick.cli").show("pi")
      end,
      desc = "Start/attach AI pane",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").show("claude")
      end,
      desc = "Sidekick Claude Code",
      mode = { "n", "v" },
    },
    {
      "<leader>ag",
      function()
        require("sidekick.cli").show("antigravity")
      end,
      desc = "Sidekick Antigravity (agy)",
      mode = { "n", "v" },
    },
    {
      "<D-e>",
      function()
        local win = vim.api.nvim_get_current_win()
        local width = vim.api.nvim_win_get_width(win)
        local total = vim.o.columns
        if width >= total - 2 then
          vim.o.winminwidth = vim.g.sidekick_saved_winminwidth or 1
          vim.g.sidekick_saved_winminwidth = nil
          vim.api.nvim_win_set_width(win, math.floor(total * 0.4))
          vim.cmd("wincmd =")
        else
          if vim.g.sidekick_saved_winminwidth == nil then
            vim.g.sidekick_saved_winminwidth = vim.o.winminwidth
          end
          vim.o.winminwidth = 0
          vim.cmd("wincmd |")
        end
      end,
      desc = "Toggle maximize window",
      mode = { "n", "t", "i", "x" },
    },
  },
}
