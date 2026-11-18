return {
  "pwntester/octo.nvim",
  init = function()
    -- vim.lsp.enable skips octo buffers (buftype=acwrite), so attach copilot by hand
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function(ev)
        require("lazy").load({ plugins = { "nvim-lspconfig" } })
        vim.api.nvim_create_autocmd("InsertEnter", {
          buffer = ev.buf,
          once = true,
          callback = vim.schedule_wrap(function()
            if vim.lsp.is_enabled("copilot") then
              vim.lsp.start(
                vim.tbl_extend("force", vim.lsp.config.copilot, { root_dir = vim.fs.root(vim.fn.getcwd(), ".git") }),
                { bufnr = ev.buf }
              )
            end
          end),
        })
      end,
    })
  end,
  opts = {
    default_delete_branch = true,
    use_local_fs = true,
    poll = { enabled = true },
    default_to_projects_v2 = false,
    suppress_missing_scope = { projects_v2 = true },
  },
}
