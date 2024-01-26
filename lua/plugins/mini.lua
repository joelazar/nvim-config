return {
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		config = function()
			local starter = require("mini.starter")
			starter.setup({
				autoopen = true,
				evaluate_single = true,
				items = {
					{ action = "ene | startinsert", name = "New file", section = "Files" },
					{ action = "NnnPicker", name = "File browser", section = "Files" },
					{ action = "Telescope oldfiles", name = "Recent files", section = "Files" },
					{ action = "Telescope find_files", name = "Find files", section = "Files" },

					{ action = "Telescope live_grep", name = "Grep", section = "Search" },
					{ action = "Telescope vim_bookmarks all", name = "Bookmarks", section = "Search" },
					{ action = "Telescope command_history", name = "Command history", section = "Search" },

					{ action = "Telescope projects", name = "Projects", section = "Session" },
					{ action = [[lua require("persistence").load()]], name = "Session restore", section = "Session" },

					{ action = "ObsidianQuickSwitch", name = "Notes", section = "Notes" },

					{ action = "qa", name = "Exit", section = "Exit" },
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				header = nil,
				footer = "",
				query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
			})
		end,
	},

	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"echasnovski/mini.bracketed",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			quickfix = { suffix = "" },
		},
	},

	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
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
				mappings = {
					add = "gsa", -- Add surrounding in Normal and Visual modes
					delete = "gsd", -- Delete surrounding
					find = "gsf", -- Find surrounding (to the right)
					find_left = "gsF", -- Find surrounding (to the left)
					highlight = "gsh", -- Highlight surrounding
					replace = "gsr", -- Replace surrounding
					update_n_lines = "gsn", -- Update `n_lines`
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

	"echasnovski/mini.misc",

	{
		"echasnovski/mini.splitjoin",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"echasnovski/mini.operators",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			replace = {
				prefix = "gR",
			},
			sort = {
				prefix = "gS",
			},
		},
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

	{
		"echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
	},
}
