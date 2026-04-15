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
      layout = {
        layout = {
          width = 0.9,
          height = 0.9,
        },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 100,
        },
      },
      sources = {
        explorer = {
          ignored = true,
          layout = {
            layout = {
              width = 40,
            },
          },
        },
        projects = {
          patterns = {
            ".obsidian",
            "go.mod",
            ".git",
            "Makefile",
            "package.json",
            ".bzr",
            ".hg",
            ".svn",
            "_darcs",
          },
          dev = { "~/Code", "~/Obsidian" },
          max_depth = 3,
        },
        git_diff = {
          layout = {
            layout = {
              width = 0.95,
              height = 0.95,
            },
          },
        },
        gh_issue = {
          layout = {
            layout = {
              width = 0.95,
              height = 0.95,
            },
          },
        },
        gh_pr = {
          layout = {
            layout = {
              width = 0.95,
              height = 0.95,
            },
          },
        },
      },
      ignored = false,
      hidden = true,
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
