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

	autotag = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = false,
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
	indent = { enable = false },
	matchup = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 2000,
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
