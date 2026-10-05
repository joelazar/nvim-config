return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  -- Skipped entirely when the local marker file ~/.config/nvim/.disable-obsidian
  -- exists (e.g. devboxes). With enabled=false lazy.nvim does not install or
  -- load the plugin: no commands, no keymaps, no events. The marker is listed
  -- in .git/info/exclude so it stays machine-local and out of the repo.
  enabled = vim.fn.filereadable(vim.fn.stdpath("config") .. "/.disable-obsidian") == 0,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/**.md",
  },

  config = function()
    local global_ob = vim.fn.exepath("ob")
    local active_sync_roots = {}

    -- Templates are written in Templater syntax so the Obsidian app renders
    -- them too. obsidian.nvim has no Templater, so evaluate the subset the
    -- templates use: `moment()` chains and `tp.date.now` / `tp.file.title`.
    local templater = (function()
      local M = {}

      local units = {
        d = "day",
        day = "day",
        days = "day",
        w = "week",
        week = "week",
        weeks = "week",
        M = "month",
        month = "month",
        months = "month",
        y = "year",
        year = "year",
        years = "year",
      }

      ---@param time integer
      ---@param n integer number of `unit`s to add (negative to subtract)
      local function add(time, n, unit)
        local d = os.date("*t", time) --[[@as osdate]]
        unit = units[unit or "day"] or "day"
        if unit == "day" then
          d.day = d.day + n
        elseif unit == "week" then
          d.day = d.day + 7 * n
        elseif unit == "month" then
          d.month = d.month + n
        else
          d.year = d.year + n
        end
        return os.time(d)
      end

      ---`moment().startOf(unit)`: isoWeek, week, day, month or year.
      local function start_of(time, unit)
        local d = os.date("*t", time) --[[@as osdate]]
        d.hour, d.min, d.sec = 0, 0, 0
        if unit == "isoWeek" or unit == "week" then
          local wday = d.wday - 1 -- 0=Sun..6=Sat
          local back = unit == "isoWeek" and ((wday == 0) and 6 or (wday - 1)) or wday
          return os.time(d) - back * 86400
        elseif unit == "month" then
          d.day = 1
        elseif unit == "year" then
          d.month, d.day = 1, 1
        end
        return os.time(d)
      end

      ---Split a call's argument list into its string and number literals.
      local function parse_args(args)
        local out = {}
        for arg in vim.gsplit(args or "", ",") do
          arg = vim.trim(arg)
          local str = arg:match([[^"(.*)"$]]) or arg:match("^'(.*)'$")
          out[#out + 1] = str or tonumber(arg)
        end
        return out
      end

      ---Evaluate one `<% ... %>` expression, or return nil if unsupported.
      ---@param expr string
      ---@param ctx obsidian.TemplateContext
      ---@return string|?
      function M.eval(expr, ctx)
        local format_date = require("obsidian.util").format_date

        if expr:match("^tp%.file%.title") then
          return ctx.partial_note and ctx.partial_note:display_name()
        end

        -- tp.date.now(format, offset_in_days)
        local date_args = expr:match("^tp%.date%.now%s*%((.*)%)%s*$")
        if date_args then
          local args = parse_args(date_args)
          local fmt = args[1] or Obsidian.opts.templates.date_format
          return format_date(add(os.time(), args[2] or 0, "day"), fmt)
        end

        -- moment().startOf(unit).add(n, unit).subtract(n, unit).format(fmt)
        local chain = expr:match("^moment%s*%(%s*%)(.*)$")
        if not chain then
          return nil
        end
        local time, out = os.time(), nil
        for method, args in chain:gmatch("%.%s*([%w_]+)%s*%(([^)]*)%)") do
          local a = parse_args(args)
          if method == "startOf" then
            time = start_of(time, a[1])
          elseif method == "add" then
            time = add(time, a[1] or 0, a[2])
          elseif method == "subtract" then
            time = add(time, -(a[1] or 0), a[2])
          elseif method == "format" then
            out = format_date(time, a[1] or Obsidian.opts.templates.date_format)
          else
            return nil -- unsupported, leave the tag untouched
          end
        end
        return out
      end

      ---Replace every supported `<% ... %>` tag in `text`.
      ---@param text string
      ---@param ctx obsidian.TemplateContext
      function M.render(text, ctx)
        return (
          text:gsub("<%%%-?(.-)%-?%%>", function(expr)
            local ok, value = pcall(M.eval, vim.trim(expr), ctx)
            if not ok then
              vim.notify("Templater tag failed: <%" .. expr .. "%> " .. tostring(value), vim.log.levels.WARN)
              return nil
            end
            return value
          end)
        )
      end

      return M
    end)()

    require("obsidian").setup({
      sync = {
        enabled = false,
      },
      callbacks = {
        enter_note = function(note)
          local api = require("obsidian.api")
          local sync = require("obsidian.sync")
          local workspace_api = require("obsidian.workspace")

          if global_ob ~= "" then
            local sync_client = require("obsidian.sync.client")
            sync_client.cmd = global_ob
            sync_client.cli = require("obsidian.cli").new(global_ob)
          end

          local path = note.path and tostring(note.path) or vim.api.nvim_buf_get_name(note.bufnr or 0)
          if path == "" then
            return
          end

          local ws = api.find_workspace(path)
          if not ws then
            return
          end

          local current = rawget(_G, "Obsidian") and Obsidian.workspace or nil
          local target_root = tostring(ws.root)

          if active_sync_roots[target_root] then
            return
          end

          if not current or tostring(current.root) ~= target_root then
            workspace_api.set(ws)
          end

          if sync.is_configured(ws) then
            sync.start(ws)
            active_sync_roots[target_root] = true
          end
        end,
      },
      workspaces = {
        {
          name = "private",
          path = "~/Obsidian/private",
        },
        {
          name = "shared",
          path = "~/Obsidian/shared",
        },
        {
          name = "work",
          path = "~/Obsidian/work",
        },
        {
          name = "journal",
          path = "~/Obsidian/journal",
        },
        {
          name = "hermes",
          path = "~/Obsidian/hermes",
        },
        {
          name = "archive",
          path = "~/Obsidian/archive",
        },
      },
      completion = {
        -- Trigger completion at 2 chars.
        min_chars = 2,
        -- Set to false to disable new note creation in the picker
        create_new = true,
      },

      legacy_commands = false,

      -- Where to put new notes. Valid options are
      -- _ "current_dir" - put new notes in same directory as the current buffer.
      -- _ "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Keep the title as-is (case preserved), just sanitize it for the file system.
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,

      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
      ---@return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,

      -- Link style configuration. Either 'wiki' or 'markdown'.
      link = {
        style = "wiki",
        auto_update = true,
      },

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      frontmatter = {
        enabled = true,
        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        func = function(note)
          -- Add the title of the note as an alias.
          if note.title then
            note:add_alias(note.title)
          end

          local out = { tags = note.tags }

          -- `note.metadata` contains any manually added fields in the frontmatter.
          -- So here we just make sure those fields are kept in the frontmatter.
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end

          return out
        end,
      },

      -- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
      templates = {
        folder = "_templates",
        -- moment.js formats, same as the Obsidian app.
        date_format = "YYYY-MM-DD",
        time_format = "HH:mm",

        -- A map for configuring unique directories and paths for specific templates
        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
        customizations = {
          ["LP"] = { notes_subdir = "LP/collection" },
        },
      },

      open = {
        use_advanced_uri = true,
        func = vim.ui.open,
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.picker'.
        name = "snacks.picker",
      },

      footer = {
        enabled = true,
      },

      -- Optional, by default, `:Obsidian backlinks` parses the header under
      -- the cursor. Setting to `false` will get the backlinks for the current
      -- note instead. Doesn't affect other link behaviour.
      backlinks = {
        parse_headers = true,
      },

      search = {
        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,

        -- Set the maximum number of lines to read from notes on disk when performing certain searches.
        max_lines = 1000,
      },

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - only open in a vertical split if a vsplit does not exist.
      -- 3. "hsplit" - only open in a horizontal split if a hsplit does not exist.
      -- 4. "vsplit_force" - always open a new vertical split if the file is not in the adjacent vsplit.
      -- 5. "hsplit_force" - always open a new horizontal split if the file is not in the adjacent hsplit.
      open_notes_in = "current",

      -- Obsidian's own conceal/extmark UI is off; render-markdown.nvim (LazyVim markdown extra) handles this.
      ui = { enable = false },

      attachments = {
        folder = "_assets",
        img_name_func = function()
          return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
        end,
        confirm_img_paste = true,
      },
      checkbox = {
        order = { " ", "/", "x", "~", "!" },
      },
    })

    -- obsidian.nvim only knows `{{var}}` substitutions, so evaluate the
    -- Templater tags first and let it handle the rest of the line.
    local templates = require("obsidian.templates")
    local substitute = templates.substitute_template_variables
    templates.substitute_template_variables = function(text, ctx)
      return substitute(templater.render(text, ctx), ctx)
    end
  end,
  keys = {
    { "<leader>zl", "<cmd>Obsidian quick_switch<cr>", desc = "List notes", mode = { "n" } },
    {
      "<leader>zL",
      function()
        local workspaces = vim.tbl_filter(function(ws)
          return ws.name ~= ".obsidian.wiki"
        end, Obsidian.workspaces or {})

        vim.ui.select(workspaces, {
          prompt = "Select vault",
          format_item = function(ws)
            return string.format("%s (%s)", ws.name, tostring(ws.root))
          end,
        }, function(ws)
          if not ws then
            return
          end
          require("obsidian.workspace").set(ws)
          Obsidian.picker.find_notes({
            prompt_title = "Quick Switch · " .. ws.name,
            dir = ws.root,
          })
        end)
      end,
      desc = "List notes from vault",
      mode = { "n" },
    },
    {
      "<leader>zn",
      function()
        local title = vim.fn.input("Title: ")
        if title ~= "" then
          vim.cmd("Obsidian new " .. title)
        end
      end,
      desc = "Create new note (in current dir)",
      mode = { "n" },
    },
    { "<leader>zl", "<cmd>Obsidian link<CR>", desc = "Link a note", mode = { "v" } },
    {
      "<leader>zn",
      function()
        local title = vim.fn.input("Title: ")
        if title ~= "" then
          vim.cmd("Obsidian link_new " .. title)
        end
      end,
      desc = "Create new linked note (in current dir)",
      mode = { "v" },
    },
    { "<leader>zb", "<cmd>Obsidian backlinks<cr>", desc = "List backlinks" },
    { "<leader>zi", "<cmd>Obsidian template<cr>", desc = "Insert template" },
    {
      "<leader>zt",
      function()
        local title = vim.fn.input("Title: ")
        if title == "" then
          return
        end
        local templates_dir = require("obsidian.api").templates_dir()
        if not templates_dir then
          vim.notify("Templates folder not defined", vim.log.levels.ERROR)
          return
        end
        Obsidian.picker.find_files({
          prompt_title = "Templates",
          dir = tostring(templates_dir),
          no_default_mappings = true,
          callback = function(path)
            local tmpl = vim.fn.fnamemodify(tostring(path), ":t:r")
            require("obsidian.actions").new_from_template(title, tmpl)
          end,
        })
      end,
      desc = "New note from template",
    },
    {
      "<leader>zw",
      function()
        -- Switch to work workspace so templates resolve correctly.
        local ws = vim.tbl_filter(function(w)
          return w.name == "work"
        end, Obsidian.workspaces or {})[1]
        if ws then
          require("obsidian.workspace").set(ws)
        end

        local name = os.date("%G-W%V")
        local dir = vim.fn.expand("~/Obsidian/work/Weekly")
        vim.fn.mkdir(dir, "p")
        local path = dir .. "/" .. name .. ".md"
        local is_new = vim.fn.filereadable(path) == 0

        vim.cmd("edit " .. vim.fn.fnameescape(path))

        if is_new then
          local api = require("obsidian.api")
          local templates_dir = api.templates_dir()
          if templates_dir then
            require("obsidian.templates").insert_template({
              type = "insert_template",
              template_name = "weekly",
              templates_dir = templates_dir,
              location = api.get_active_window_cursor_location(),
            })
          end
        end
      end,
      desc = "Open/create weekly note",
    },
    { "<leader>zo", "<cmd>Obsidian open<cr>", desc = "Open obsidian" },
    { "<leader>zs", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    {
      "<leader>zS",
      function()
        local workspaces = vim.tbl_filter(function(ws)
          return ws.name ~= ".obsidian.wiki"
        end, Obsidian.workspaces or {})

        vim.ui.select(workspaces, {
          prompt = "Select vault",
          format_item = function(ws)
            return string.format("%s (%s)", ws.name, tostring(ws.root))
          end,
        }, function(ws)
          if not ws then
            return
          end
          require("obsidian.workspace").set(ws)
          Obsidian.picker.grep_notes({
            prompt_title = "Search notes · " .. ws.name,
            dir = ws.root,
          })
        end)
      end,
      desc = "Search notes from vault",
    },
    { "<leader>zW", "<cmd>Obsidian workspace<cr>", desc = "Select active workspace" },
    { "<C-c>", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox states", ft = "markdown" },
    { "gf", "<cmd>Obsidian follow_link<CR>", desc = "Follow Obsidian link", ft = "markdown" },
  },
}
