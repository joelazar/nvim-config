return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = {
    { "<leader>aa", false },
    { "<leader>ax", false },
    { "<leader>aq", false },
    { "<leader>ap", false },
    { "<leader>ac", "", desc = "+copilotchat", mode = { "n", "v" } },
    {
      "<leader>aca",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>acx",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>acq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>acp",
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
  },
  opts = {
    model = "gpt-4.1",
    show_help = false,
    auto_insert_mode = false,
    mappings = {
      reset = {
        normal = "<D-k>",
        insert = "<D-k>",
      },
    },
  },
}
