return {
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		config = function()
			local starter = require("mini.starter")
			starter.setup({
				-- Whether to open starter buffer on VimEnter. Not opened if Neovim was
				-- started with intent to show something else.
				autoopen = true,
				-- Whether to evaluate action of single active item
				evaluate_single = false,
				-- Items to be displayed. Should be an array with the following elements:
				-- - Item: table with <action>, <name>, and <section> keys.
				-- - Function: should return one of these three categories.
				-- - Array: elements of these three types (i.e. item, array, function).
				-- If `nil` (default), default items will be used (see |mini.starter|).
				-- items = nil,
				items = {
					{ action = "bdelete", name = "New file", section = "Files" },
					{ action = "Telescope file_browser", name = "File browser", section = "Files" },
					{ action = "Telescope oldfiles", name = "Recent files", section = "Files" },
					{ action = "Telescope find_files", name = "Find files", section = "Files" },
					{ action = "Telescope live_grep", name = "Grep", section = "Search" },
					{ action = "Telescope projects", name = "Projects", section = "Search" },
					{ action = "Telescope vim_bookmarks", name = "Bookmarks", section = "Search" },
					{ action = "Telescope command_history", name = "Command history", section = "Search" },
					{ action = "ZkNotes", name = "Notes", section = "Notes" },
					{ action = "ZkNew", name = "Create note", section = "Notes" },
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				-- Header to be displayed before items. Converted to single string via
				-- `tostring` (use `\n` to display several lines). If function, it is
				-- evaluated first. If `nil` (default), polite greeting will be used.
				header = nil,
				-- Footer to be displayed after items. Converted to single string via
				-- `tostring` (use `\n` to display several lines). If function, it is
				-- evaluated first. If `nil` (default), default usage help will be shown.
				footer = "",
				-- Array  of functions to be applied consecutively to initial content.
				-- Each function should take and return content for 'Starter' buffer (see
				-- |mini.starter| and |MiniStarter.content| for more details).
				-- content_hooks = nil,

				-- Characters to update query. Each character will have special buffer
				-- mapping overriding your global ones. Be careful to not add `:` as it
				-- allows you to go into command mode.
				query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
			})
		end,
	},

	{
		"echasnovski/mini.trailspace",
		event = "BufRead",
		config = function()
			require("mini.trailspace").setup()
		end,
	},

	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			require("mini.bracketed").setup()
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				n_lines = 50,
				highlight_duration = 500,
				custom_surroundings = {
					["("] = { output = { left = "(", right = ")" } },
					[")"] = { output = { left = "(", right = ")" } },
					["["] = { output = { left = "[", right = "]" } },
					["]"] = { output = { left = "[", right = "]" } },
				},
			})
		end,
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({
				-- Number of lines within which textobject is searched
				n_lines = 500,
			})
		end,
	},

	{
		"echasnovski/mini.basics",
		event = "VimEnter",
		config = function()
			require("mini.basics").setup({
				-- Mappings. Set to `false` to disable.
				mappings = {
					-- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
					-- Supply empty string to not create these mappings.
					option_toggle_prefix = [[<leader>T]],
					-- Window navigation with <C-hulk>, resize with <C-arrow>
					windows = false,
				},
				autocommands = {
					-- Basic autocommands (highlight on yank, start Insert in terminal, ...)
					basic = false,
				},
			})
		end,
	},
}
