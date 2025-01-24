local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then
      LazyVim.warn("No " .. kind .. " found on the current line")
      return
    end
    local ok = pcall(require, "fzf-lua")
    require("CopilotChat.integrations." .. (ok and "fzflua" or "telescope")).pick(items)
  end
end

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
    -- Show prompts actions with telescope
    { "<leader>acp", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
  },
}
