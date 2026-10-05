-- LSP configuration
-- Tweaks LSP keymaps, gopls settings, and adds harper_ls / nginx servers
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
    opts.servers.harper_ls = { filetypes = { "markdown", "gitcommit", "text" } }
    opts.servers.nginx_language_server = {}

    opts.setup = opts.setup or {}

    opts.setup.harper_ls = function(server, sopts)
      vim.lsp.config(server, sopts)
      Snacks.toggle({
        name = "Harper",
        get = function()
          return vim.lsp.is_enabled("harper_ls")
        end,
        set = function(state)
          vim.lsp.enable("harper_ls", state)
        end,
      }):map("<leader>uH")
      return true
    end
  end,
}
