return {
	"epwalsh/obsidian.nvim",
	event = { "BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = {
		"ObsidianBacklinks",
		"ObsidianLink",
		"ObsidianLinkNew",
		"ObsidianNew",
		"ObsidianOpen",
		"ObsidianQuickSwitch",
		"ObsidianSearch",
		"ObsidianTemplate",
		"ObsidianToday",
		"ObsidianYesterday",
	},
	config = function()
		require("obsidian").setup({
			dir = "~/notes",

			-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
			-- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
			-- log_level = vim.log.levels.DEBUG,

			daily_notes = {
				folder = "journal/daily",
				date_format = "%Y-%m-%d",
			},

			completion = {
				nvim_cmp = true,
				min_chars = 2,
				-- Where to put new notes created from completion. Valid options are
				--  * "current_dir" - put new notes in same directory as the current buffer.
				--  * "notes_subdir" - put new notes in the default notes subdirectory.
				new_notes_location = "current_dir",

				-- Whether to add the output of the node_id_func to new notes in autocompletion.
				-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
				prepend_note_id = false,
			},

			-- Optional, key mappings.
			mappings = {
				-- 	-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				-- 	["gf"] = require("obsidian.mapping").gf_passthrough(),
			},

			-- Optional, customize how names/IDs for new notes are created.
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
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

			-- Optional, set to true if you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = false,

			templates = {
				subdir = "_templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},

			backlinks = { height = 10, wrap = true },

			-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
			-- URL it will be ignored but you can customize this behavior here.
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				vim.fn.jobstart({ "xdg-open", url }) -- linux
			end,

			-- Optional, set to true if you use the Obsidian Advanced URI plugin.
			-- https://github.com/Vinzent03/obsidian-advanced-uri
			use_advanced_uri = false,

			-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
			open_app_foreground = false,

			-- Optional, by default commands like `:ObsidianSearch` will attempt to use
			-- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
			-- first one they find. By setting this option to your preferred
			-- finder you can attempt it first. Note that if the specified finder
			-- is not installed, or if it the command does not support it, the
			-- remaining finders will be attempted in the original order.
			finder = "telescope.nvim",

			-- Optional, determines whether to open notes in a horizontal split, a vertical split,
			-- or replacing the current buffer (default)
			-- Accepted values are "current", "hsplit" and "vsplit"
			open_notes_in = "current",
		})
		vim.keymap.set("n", "gf", function()
			if require("obsidian").util.cursor_on_markdown_link() then
				return "<cmd>ObsidianFollowLink<CR>"
			else
				return "gf"
			end
		end, { noremap = false, expr = true })
	end,
}
