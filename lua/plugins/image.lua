return {
	"3rd/image.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- + luarocks --lua-version=5.1 install magick
	},
	ft = { "markdown" },
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				sizing_strategy = "auto",
				download_remote_images = true,
				clear_in_insert_mode = false,
			},
			neorg = {
				enabled = false,
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		kitty_method = "normal",
		kitty_tmux_write_delay = 10,
		window_overlap_clear_enabled = false,
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	},
}
