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
    image = {
      math = { enabled = false },
    },
    indent = {
      scope = { enabled = false },
      animate = { enabled = false },
    },
    scroll = {
      enabled = false,
    },
    picker = {
      matcher = { frecency = true },
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
          win = {
            list = {
              keys = {
                ["x"] = "explorer_cut",
              },
            },
          },
          actions = {
            explorer_cut = function(picker)
              local files = {}
              for _, item in ipairs(picker:selected({ fallback = true })) do
                if item.file then
                  table.insert(files, item.file)
                end
              end
              if #files == 0 then
                return
              end
              local value = table.concat(files, "\n")
              vim.fn.setreg("+", value, "l")
              vim.fn.setreg(vim.v.register, value, "l")
              vim.g.snacks_explorer_cut = files
              picker.list:set_selected()
            end,
            explorer_paste = function(picker)
              local files = vim.tbl_filter(function(f)
                return f ~= ""
              end, vim.split(vim.fn.getreg(vim.v.register) or "", "\n", { plain = true }))
              local is_cut = vim.deep_equal(files, vim.g.snacks_explorer_cut)
              files = vim.tbl_filter(function(f)
                return vim.fn.filereadable(f) == 1 or vim.fn.isdirectory(f) == 1
              end, files)
              if #files == 0 then
                return Snacks.notify.warn("Nothing to paste")
              end
              local dir = picker:dir()
              local function done()
                require("snacks.explorer.tree"):refresh(dir)
                require("snacks.explorer.tree"):open(dir)
                require("snacks.explorer.actions").update(picker, { target = dir })
              end
              if not is_cut then
                Snacks.picker.util.copy(files, dir)
                return done()
              end
              vim.g.snacks_explorer_cut = nil
              for _, src in ipairs(files) do
                local dest = dir .. "/" .. vim.fs.basename(src)
                if vim.uv.fs_stat(dest) then
                  Snacks.notify.error(("Move skipped, `%s` already exists"):format(dest))
                else
                  Snacks.rename.rename_file({ from = src, to = dest })
                  require("snacks.explorer.tree"):refresh(vim.fs.dirname(src))
                end
              end
              done()
            end,
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
        Snacks.picker.files()
      end,
      desc = "Find Files (Root Dir)",
    },
  },
}
