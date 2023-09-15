local M = {
	"romgrk/barbar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<A-Left>",  "<cmd>BufferPrevious<cr>",     mode = "n", desc = "Move to previous buffer" },
    { "<A-Right>", "<cmd>BufferNext<cr>",         mode = "n", desc = "Move to next buffer" },
    { "<A-Tab>",   "<cmd>BufferNext<cr>",         mode = "n", desc = "Move to next buffer" },
    { "<A-,>",     "<cmd>BufferMovePrevious<cr>", mode = "n", desc = "Re-order to previous buffer" },
    { "<A-.>",     "<cmd>BufferMoveNext<cr>",     mode = "n", desc = "Re-order to next buffer" },
    { "<A-1>",     "<cmd>BufferGoto 1<cr>",       mode = "n", desc = "Goto buffer in position 1" },
    { "<A-2>",     "<cmd>BufferGoto 2<cr>",       mode = "n", desc = "Goto buffer in position 2" },
    { "<A-3>",     "<cmd>BufferGoto 3<cr>",       mode = "n", desc = "Goto buffer in position 3" },
    { "<A-4>",     "<cmd>BufferGoto 4<cr>",       mode = "n", desc = "Goto buffer in position 4" },
    { "<A-5>",     "<cmd>BufferGoto 5<cr>",       mode = "n", desc = "Goto buffer in position 5" },
    { "<A-6>",     "<cmd>BufferGoto 6<cr>",       mode = "n", desc = "Goto buffer in position 6" },
    { "<A-7>",     "<cmd>BufferGoto 7<cr>",       mode = "n", desc = "Goto buffer in position 7" },
    { "<A-8>",     "<cmd>BufferGoto 8<cr>",       mode = "n", desc = "Goto buffer in position 8" },
    { "<A-9>",     "<cmd>BufferGoto 9<cr>",       mode = "n", desc = "Goto buffer in position 9" },
    { "<A-0>",     "<cmd>BufferLast<cr>",         mode = "n", desc = "Goto last buffer" },
    { "<A-p>",     "<cmd>BufferPin<cr>",          mode = "n", desc = "Pin buffer" },
    { "<A-c>",     "<cmd>BufferClose<cr>",        mode = "n", desc = "Close buffer" },
  }
,
}

M.config = function()
	require("bufferline").setup({
		-- Enable/disable animations
		animation = false,

		-- Enable/disable auto-hiding the tab bar when there is a single buffer
		auto_hide = false,

		-- Enable/disable current/total tabpages indicator (top right corner)
		tabpages = true,

		-- Enables/disable clickable tabs
		--  - left-click: go to buffer
		--  - middle-click: delete buffer
		clickable = false,

		-- Disable highlighting alternate buffers
		highlight_alternate = false,

		-- Disable highlighting file icons in inactive buffers
		highlight_inactive_file_icons = false,

		-- Enable highlighting visible buffers
		highlight_visible = true,

		icons = {
			-- Configure the base icons on the bufferline.
			buffer_index = false,
			buffer_number = false,
			button = "",
			-- Enables / disables diagnostic symbols
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = false, icon = "ﬀ" },
				[vim.diagnostic.severity.WARN] = { enabled = false },
				[vim.diagnostic.severity.INFO] = { enabled = false },
				[vim.diagnostic.severity.HINT] = { enabled = false },
			},
			gitsigns = {
				added = { enabled = false, icon = "+" },
				changed = { enabled = false, icon = "~" },
				deleted = { enabled = false, icon = "-" },
			},
			filetype = {
				-- Sets the icon's highlight group.
				-- If false, will use nvim-web-devicons colors
				custom_colors = true,

				-- Requires `nvim-web-devicons` if `true`
				enabled = true,
			},
			separator = { left = "", right = "" },

			-- Configure the icons on the bufferline when modified or pinned.
			-- Supports all the base icon options.
			modified = { button = "●" },
			pinned = { button = "車", filename = true, separator = { right = "" } },

			-- Configure the icons on the bufferline based on the visibility of a buffer.
			-- Supports all the base icon options, plus `modified` and `pinned`.
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = false },
			inactive = { button = nil, separator = { left = "", right = "" } },
			visible = { modified = { buffer_number = false } },
		},

		-- If true, new buffers will be inserted at the start/end of the list.
		-- Default is to insert after current buffer.
		insert_at_end = true,
		insert_at_start = false,

		-- Sets the maximum padding width with which to surround each tab
		maximum_padding = 1,

		-- Sets the minimum padding width with which to surround each tab
		minimum_padding = 1,

		-- Sets the maximum buffer name length.
		maximum_length = 30,

		-- If set, the letters for each buffer in buffer-pick mode will be
		-- assigned based on their name. Otherwise or in case all letters are
		-- already assigned, the behavior is to assign letters in order of
		-- usability (see order below)
		semantic_letters = true,

		-- New buffer letters are assigned in this order. This order is
		-- optimal for the qwerty keyboard layout but might need adjustment
		-- for other layouts.
		letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

		-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
		-- where X is the buffer number. But only a static string is accepted here.
		no_name_title = nil,
	})
end

return M
