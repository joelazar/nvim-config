local M = {}

M.config = {
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"comment",
		"cpp",
		"css",
		"dockerfile",
		"fish",
		"go",
		"gomod",
		"html",
		"http",
		"javascript",
		"json",
		"latex",
		"lua",
		"make",
		"prisma",
		"python",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	ignore_install = {},
	sync_install = true,
	highlight = {
		enable = true, -- false will disable the whole extension
		use_languagetree = true,
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	-- indent = { enable = true, disable = {} }, -- EXPERIMENTAL feature
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
	},
	autotag = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	matchup = {
		enable = true,
	},
}

M.setup = function()
	local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end
	treesitter_configs.setup(M.config)
end

return M
