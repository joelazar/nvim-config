-- LSP configuration
-- Disables some default LSP keybindings and adds golangci_lint_ls server
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["*"] = opts.servers["*"] or {}
    opts.servers["*"].keys = opts.servers["*"].keys or {}

    vim.list_extend(opts.servers["*"].keys, {
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
        mode = { "n", "x" },
        has = "codeAction",
      },
    })

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

    opts.setup = opts.setup or {}

    -- LazyVim's Go extra assumes semantic token capabilities are always present.
    -- Some completion/LSP capability providers omit them, which causes:
    --   attempt to index local 'semantic' (a nil value)
    opts.setup.gopls = function(_, server_opts)
      Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
        if client.server_capabilities.semanticTokensProvider then
          return
        end

        local semantic = client.config.capabilities
          and client.config.capabilities.textDocument
          and client.config.capabilities.textDocument.semanticTokens

        if semantic and semantic.tokenTypes and semantic.tokenModifiers then
          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
              tokenTypes = semantic.tokenTypes,
              tokenModifiers = semantic.tokenModifiers,
            },
            range = true,
          }
        end
      end)
    end

    -- Setup function to prevent harper_ls from autostarting
    opts.setup.harper_ls = function(_, server_opts)
      -- Don't setup harper_ls automatically
      return true
    end
  end,
}
