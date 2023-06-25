return {
	-- Useful lua function collection
	"nvim-lua/plenary.nvim",

	-- Devicons
	"kyazdani42/nvim-web-devicons",

	-- Swap parameters easier
	{
		"mizlan/iswap.nvim",
		cmd = "ISwap",
	},

	-- Better % navigation
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	{
		"willothy/flatten.nvim",
		config = true,
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
	},

	-- Training for vim movements
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},

	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- Bookmarks
	{
		"MattesGroeger/vim-bookmarks",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- Check git history
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
			"DiffviewRefresh",
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff4_mixed",
					disable_diagnostics = true,
				},
			},
		},
	},

	-- Generate shareable file permalinks
	"ruifm/gitlinker.nvim",

	-- Better quickfix
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
	},

	-- Nicer diagnostics
	{
		"folke/lsp-trouble.nvim",
		opts = { auto_preview = false, auto_fold = true, auto_close = true },
		cmd = { "TroubleToggle", "Trouble" },
	},

	-- GitHub integration for issues and prs
	{
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
			require("telescope").load_extension("octo")
		end,
		cmd = { "Octo" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},

	-- Enhanced folds
	{
		"kevinhwang91/nvim-ufo",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
		dependencies = "kevinhwang91/promise-async",
		event = { "BufRead", "BufNewFile" },
	},

	-- Task runner for Neovim
	{
		"stevearc/overseer.nvim",
		config = true,
		cmd = { "OverseerRun", "OverseerRestartLast", "OverseerToggle" },
	},

	-- Highlight function arguments
	{
		"m-demare/hlargs.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		event = { "BufReadPre", "BufNewFile" },
	},

	-- Quick annotation generator
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
	},

	-- Change strings to template string on the fly in jsx/tsx
	{
		"axelvc/template-string.nvim",
		config = true,
		ft = {
			"javascriptreact",
			"typescriptreact",
		},
	},

	-- Refactoring library based off the Refactoring book by Martin Fowler
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = true,
	},

	"folke/twilight.nvim",

	{ "mrjones2014/smart-splits.nvim", build = "./kitty/install-kittens.bash" },

	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user --break-system-packages .",
		ft = "python",
	},
}
