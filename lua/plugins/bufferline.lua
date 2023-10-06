return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.bufremove",
	},
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			options = {
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
		})
	end,
	keys = {
		{ "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", mode = "n", desc = "Move to previous buffer" },
		{ "<A-Right>", "<cmd>BufferLineCycleNext<cr>", mode = "n", desc = "Move to next buffer" },
		{ "<A-Tab>", "<cmd>BufferLineCycleNext<cr>", mode = "n", desc = "Move to next buffer" },
		{ "<A-,>", "<cmd>BufferLineMovePrev<cr>", mode = "n", desc = "Re-order to previous buffer" },
		{ "<A-.>", "<cmd>BufferLineMoveNext<cr>", mode = "n", desc = "Re-order to next buffer" },
		{ "<A-p>", "<cmd>BufferLineTogglePin<cr>", mode = "n", desc = "Pin buffer" },
	},
}
