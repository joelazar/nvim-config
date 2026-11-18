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
  config = function(_, opts)
    require("octo").setup(opts)

    local Review = require("octo.reviews").Review
    local dir = vim.fn.stdpath("state") .. "/octo-review-drafts"
    vim.fn.mkdir(dir, "p")
    local function draft_path(review)
      return string.format("%s/%s-%d.md", dir, review.pull_request.repo:gsub("/", "_"), review.pull_request.number)
    end

    local collect = Review.collect_submit_info
    function Review:collect_submit_info()
      collect(self)
      local bufnr = vim.api.nvim_get_current_buf()
      local path = draft_path(self)
      if vim.uv.fs_stat(path) then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.readfile(path))
        vim.cmd("normal! G")
      end
      vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.fn.writefile(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), path)
        end,
      })
    end

    local submit = Review.submit
    function Review:submit(event)
      local path = draft_path(self)
      local tabpage = self.layout.tabpage
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            -- octo only closes the review tab after a successful submit
            if not vim.api.nvim_tabpage_is_valid(tabpage) then
              os.remove(path)
            end
          end)
        end,
      })
      submit(self, event)
    end
  end,
}
