return {
  "folke/edgy.nvim",
  opts = function(_, opts)
    opts.animate = opts.animate or {}
    opts.animate.enabled = false

    opts.options = opts.options or {}
    opts.options.right = opts.options.right or {}
    opts.options.bottom = opts.options.bottom or {}

    -- Edgy side width is controlled by edgebar option size, not view.width.
    opts.options.right.size = 0.3
    opts.options.bottom.size = 0.35

    opts.right = opts.right or {}
    for _, view in ipairs(opts.right) do
      if type(view) == "table" and view.ft == "dbui" then
        view.title = "Database"
        view.pinned = true
        view.size = { width = 0.3 }
        view.open = function()
          vim.cmd("DBUI")
        end
      end
    end

    opts.bottom = opts.bottom or {}
    for _, view in ipairs(opts.bottom) do
      if type(view) == "table" and view.ft == "dbout" then
        view.title = "DB Query Result"
        view.size = { height = 0.35 }
      end
    end
  end,
}
