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
          win = {
            list = {
              keys = {
                ["x"] = "explorer_cut",
              },
            },
          },
          actions = {
            explorer_cut = function(picker)
              local sel = picker:selected({ fallback = true })
              local files = {}
              for _, item in ipairs(sel) do
                if item.file then
                  table.insert(files, item.file)
                end
              end
              if #files == 0 then
                return
              end
              vim.fn.setreg("+", table.concat(files, "\n"))
              vim.g.snacks_explorer_cut = files
              picker.list:set_selected()
            end,
            explorer_paste = function(picker)
              local cut = vim.g.snacks_explorer_cut or {}
              local files
              local is_cut = #cut > 0
              if is_cut then
                files = vim.deepcopy(cut)
              else
                files = vim.split(vim.fn.getreg("+") or "", "\n", { plain = true })
              end
              files = vim.tbl_filter(function(f)
                return f ~= "" and (vim.fn.filereadable(f) == 1 or vim.fn.isdirectory(f) == 1)
              end, files)
              if #files == 0 then
                return Snacks.notify.warn("Nothing to paste")
              end
              local dir = picker:dir()
              if is_cut then
                for _, src in ipairs(files) do
                  local dest = dir .. "/" .. vim.fs.basename(src)
                  local ok, err = vim.uv.fs_rename(src, dest)
                  if not ok then
                    Snacks.notify.error(("Move failed: %s -> %s\n%s"):format(src, dest, err))
                  end
                end
                vim.g.snacks_explorer_cut = nil
              else
                Snacks.picker.util.copy(files, dir)
              end
              require("snacks.explorer.tree"):refresh(dir)
              require("snacks.explorer.tree"):open(dir)
              require("snacks.explorer.actions").update(picker, { target = dir })
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
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files (Root Dir)",
    },
  },
}
