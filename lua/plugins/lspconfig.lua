-- LSP configuration
-- Disables some default LSP keybindings and adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable keymaps
    keys[#keys + 1] = { "<a-p>", false }
    keys[#keys + 1] = { "<a-n>", false }
    -- map cd to LSP rename using inc-rename
    keys[#keys + 1] = {
      "cd",
      function()
        local inc_rename = require("inc_rename")
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename (inc-rename.nvim)",
      has = "rename",
    }

    -- configure Go LSP servers
    opts.servers = opts.servers or {}
    opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
      settings = {
        gopls = {
          staticcheck = false,
          experimentalPostfixCompletions = true,
        },
      },
    })
    opts.servers.golangci_lint_ls = {}
    opts.servers.harper_ls = {}

    -- Setup function to prevent harper_ls from autostarting
    opts.setup = opts.setup or {}
    opts.setup.harper_ls = function(_, server_opts)
      -- Don't setup harper_ls automatically
      return true
    end
  end,
}
