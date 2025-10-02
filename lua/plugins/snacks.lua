-- Snacks.nvim configuration
-- Provides dashboard, indent guides, and file picker
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[Hey Joe 👋!]],
      },
    },
    image = {},
    indent = {
      scope = { enabled = false },
      animate = { enabled = false },
    },
    scroll = {
      enabled = false,
    },
    picker = {
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 100, -- truncate the file path to (roughly) this length
        },
      },
      hidden = true, -- show hidden files by default
    },
    statuscolumn = {},
  },
  keys = {
    {
      "<C-p>",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files (Root Dir)",
    },
  },
}

