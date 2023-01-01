local M = {
	"romgrk/barbar.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	event = "BufAdd",
}

M.config = function()
	require("bufferline").setup({
		-- Enable/disable animations
		animation = false,

		-- Enable/disable auto-hiding the tab bar when there is a single buffer
		auto_hide = false,

		-- Enable/disable current/total tabpages indicator (top right corner)
		tabpages = true,

		-- Enable/disable close button
		closable = false,

		-- Enables/disable clickable tabs
		--  - left-click: go to buffer
		--  - middle-click: delete buffer
		clickable = false,

		-- Enable/disable icons
		-- if set to 'numbers', will show buffer index in the tabline
		-- if set to 'both', will show buffer index and icons in the tabline
		icons = true,

		-- If set, the icon color will follow its corresponding buffer
		-- highlight group. By default, the Buffer*Icon group is linked to the
		-- Buffer* group (see Highlighting below). Otherwise, it will take its
		-- default value as defined by devicons.
		icon_custom_colors = true,

		-- Configure icons on the bufferline.
		icon_separator_active = "▎",
		icon_separator_inactive = "▎",
		icon_close_tab = "",
		icon_close_tab_modified = "●",
		icon_pinned = "車",

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
		-- optimal for the qwerty keyboard layout but might need adjustement
		-- for other layouts.
		letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

		-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
		-- where X is the buffer number. But only a static string is accepted here.
		no_name_title = nil,
	})
end

return M
