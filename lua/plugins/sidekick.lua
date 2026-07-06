return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        split = {
          width = 0.4,
        },
      },
      mux = {
        backend = "tmux",
        enabled = true,
      },
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
        local cli = require("sidekick.cli")
        local saved_width
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "sidekick_terminal" then
            saved_width = vim.api.nvim_win_get_width(win)
            break
          end
        end
        if saved_width then
          vim.g.sidekick_last_width = saved_width
        end
        cli.toggle("pi")
        if saved_width then
          return
        end
        vim.defer_fn(function()
          local last = vim.g.sidekick_last_width
          if not last then
            return
          end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "sidekick_terminal" then
              vim.api.nvim_win_set_width(win, last)
              break
            end
          end
        end, 50)
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
