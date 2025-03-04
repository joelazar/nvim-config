return {
  "zbirenbaum/copilot.lua",
  opts = {
    copilot_node_command = "/opt/homebrew/bin/node", -- so Copilot works in projects where node <18 is used
    filetypes = {
      -- Enable Copilot for specific filetypes
      yaml = true,
      gitcommit = true,
      gitrebase = true,
      conf = false,
      -- Disable for dot files
      ["."] = false,
      -- Custom handling for markdown files
      markdown = function()
        -- Disable Copilot in Obsidian vault directories
        if string.match(vim.fn.expand("%:p:h"), "obsidian") then
          return false
        end
        return true
      end,
      -- Custom handling for fish shell scripts
      fish = function()
        -- Disable Copilot for hidden files (starting with .)
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%..*") then
          return false
        end
        return true
      end,
      -- Custom handling for shell scripts
      sh = function()
        -- Disable Copilot for hidden files (starting with .)
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%..*") then
          return false
        end
        return true
      end,
    },
  },
}
