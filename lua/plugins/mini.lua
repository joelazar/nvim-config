local M = {
	"echasnovski/mini.nvim",
	event = "VimEnter",
}

M.config = function()
	require("mini.trailspace").setup({
		-- Highlight only in normal buffers (ones with empty 'buftype'). This is
		-- useful to not show trailing whitespace where it usually doesn't matter.
		only_in_normal_buffers = true,
	})

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
end

return M
