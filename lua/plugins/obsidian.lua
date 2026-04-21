return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md" },

  config = function()
    local global_ob = vim.fn.exepath("ob")
    local active_sync_roots = {}

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
          name = "home",
          path = "~/Obsidian/home",
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
          name = "archive",
          path = "~/Obsidian/archive",
        },
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = false,
        -- Enables completion using blink.cmp
        blink = true,
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
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
        -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
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
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function.
        -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
        -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
        substitutions = (function()
          local day = 86400
          local fmt_week = function(t) return os.date("%G-W%V", t) end
          local fmt_day = function(t) return os.date("%Y.%m.%d - %A", t) end
          -- Monday 00:00 of current ISO week.
          local monday = function()
            local t = os.time()
            local wday = tonumber(os.date("%w", t)) -- 0=Sun..6=Sat
            local offset = (wday == 0) and 6 or (wday - 1)
            local d = os.date("*t", t - offset * day)
            d.hour, d.min, d.sec = 0, 0, 0
            return os.time(d)
          end
          return {
            week = function() return fmt_week(monday()) end,
            last_week = function() return fmt_week(monday() - 7 * day) end,
            next_week = function() return fmt_week(monday() + 7 * day) end,
            day1 = function() return fmt_day(monday() + 0 * day) end,
            day2 = function() return fmt_day(monday() + 1 * day) end,
            day3 = function() return fmt_day(monday() + 2 * day) end,
            day4 = function() return fmt_day(monday() + 3 * day) end,
            day5 = function() return fmt_day(monday() + 4 * day) end,
          }
        end)(),

        -- A map for configuring unique directories and paths for specific templates
        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
        customizations = {
          ["LP"] = { notes_subdir = "LP/collection" },
        },
      },

      ---@class obsidian.config.OpenOpts
      ---
      ---Opens the file with current line number
      ---@field use_advanced_uri? boolean
      ---
      ---Function to do the opening, default to vim.ui.open
      ---@field func? fun(uri: string)
      open = {
        use_advanced_uri = true,
        func = vim.ui.open,
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
        name = "snacks.pick",
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

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = false, -- set to false to disable all additional syntax features
        ignore_conceal_warn = false, -- set to true to disable conceallevel specific warning
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      ---@class obsidian.config.AttachmentsOpts
      ---
      ---Default folder to save images to, relative to the vault root.
      ---@field folder? string
      ---
      ---Default name for pasted images
      ---@field img_name_func? fun(): string
      ---
      ---Default text to insert for pasted images, for customizing, see: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images
      ---@field img_text_func? fun(path: obsidian.Path): string
      ---
      ---Whether to confirm the paste or not. Defaults to true.
      ---@field confirm_img_paste? boolean
      attachments = {
        folder = "_assets",
        img_name_func = function()
          return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
        end,
        confirm_img_paste = true,
      },
      ---@class obsidian.config.CheckboxOpts
      ---
      ---Order of checkbox state chars, e.g. { " ", "x" }
      ---@field order? string[]
      checkbox = {
        order = { " ", "x", "/", "~", "!", ">" },
      },
    })
  end,
  keys = {
    { "<leader>z", "", desc = "+obsidian", mode = { "n", "v" } },
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
            local tmpl = vim.fn.fnamemodify(path, ":t:r")
            vim.cmd(string.format("Obsidian new_from_template %s %s", title, tmpl))
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
    { "<C-c>", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox states" },
    { "gf", "<cmd>Obsidian follow_link<CR>", desc = "Follow Obsidian link" },
  },
}
