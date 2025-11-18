-- LSP configuration
-- Disables some default LSP keybindings and adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["*"] = {
      keys = {
        -- disable keymaps
        { "<a-p>", false },
        { "<a-n>", false },
        -- map cd to LSP rename using inc-rename
        {
          "cd",
          function()
            local inc_rename = require("inc_rename")
            return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
          end,
          expr = true,
          desc = "Rename (inc-rename.nvim)",
          has = "rename",
        },
        -- map <leader>ca to code actions
        {
          "<leader>ca",
          vim.lsp.buf.code_action,
          desc = "Code Action",
          has = "codeAction",
        },
      },
    }

    -- configure Go LSP servers
    opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
      settings = {
        gopls = {
          staticcheck = false,
          experimentalPostfixCompletions = true,
        },
      },
    })
    opts.servers.harper_ls = {}

    -- Setup function to prevent harper_ls from autostarting
    opts.setup = opts.setup or {}
    opts.setup.harper_ls = function(_, server_opts)
      -- Don't setup harper_ls automatically
      return true
    end
  end,
}
