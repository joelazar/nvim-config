return {
  "obsidian-nvim/obsidian.nvim",
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "ObsidianBacklinks",
    "ObsidianDailies",
    "ObsidianExtractNote",
    "ObsidianFollowLink",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianLinks",
    "ObsidianNew",
    "ObsidianOpen",
    "ObsidianPasteImg",
    "ObsidianQuickSwitch",
    "ObsidianRename",
    "ObsidianSearch",
    "ObsidianTags",
    "ObsidianTemplate",
    "ObsidianToday",
    "ObsidianTomorrow",
    "ObsidianWorkspace",
    "ObsidianYesterday",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "private",
          path = "~/Obsidian/private",
        },
        {
          name = "home",
          path = "~/Obsidian/home",
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

      -- Optional, customize how wiki links are formatted. You can set this to one of:
      -- _ "use_alias_only", e.g. '[[Foo Bar]]'
      -- _ "prepend*note_id", e.g. '[[foo-bar|Foo Bar]]'
      -- * "prepend*note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      -- * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string, like this:
      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
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

      -- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
      templates = {
        folder = "_templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function.
        -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
        -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
        substitutions = {},

        -- A map for configuring unique directories and paths for specific templates
        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
        customizations = {},
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

      -- Optional, by default, `:ObsidianBacklinks` parses the header under
      -- the cursor. Setting to `false` will get the backlinks for the current
      -- note instead. Doesn't affect other link behaviour.
      backlinks = {
        parse_headers = true,
      },

      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
      sort_by = "modified",
      sort_reversed = true,

      -- Set the maximum number of lines to read from notes on disk when performing certain searches.
      search_max_lines = 1000,

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
      ---@field img_folder? string
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
        img_folder = "_assets",
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
        order = { " ", "~", "!", ">", "x" },
      },
    })
  end,
  keys = {
    { "<leader>z", "", desc = "+obsidian", mode = { "n", "v" } },
    { "<leader>zl", "<cmd>ObsidianQuickSwitch<cr>", desc = "List notes", mode = { "n" } },
    {
      "<leader>zn",
      function()
        local title = vim.fn.input("Title: ")
        if title ~= "" then
          vim.cmd("ObsidianNew " .. title)
        end
      end,
      desc = "Create new note (in current dir)",
      mode = { "n" },
    },
    { "<leader>zl", "<cmd>ObsidianLink<CR>", desc = "Link a note", mode = { "v" } },
    {
      "<leader>zn",
      function()
        local title = vim.fn.input("Title: ")
        if title ~= "" then
          vim.cmd("ObsidianLinkNew " .. title)
        end
      end,
      desc = "Create new linked note (in current dir)",
      mode = { "v" },
    },
    { "<leader>zb", "<cmd>ObsidianBacklinks<cr>", desc = "List backlinks" },
    { "<leader>zi", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>zo", "<cmd>ObsidianOpen<cr>", desc = "Open obsidian" },
    { "<leader>zs", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>zw", "<cmd>ObsidianWorkspace<cr>", desc = "Select active workspace" },
    { "<C-c>", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox states" },
    { "gf", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Obsidian link" },
  },
}
