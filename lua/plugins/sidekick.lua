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
    nes = {
      enabled = function(buf)
        if vim.g.sidekick_nes == false or vim.b.sidekick_nes == false then
          return false
        end
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        if filetype == "markdown" then
          return false
        end
        return true
      end,
    },
  },
}
