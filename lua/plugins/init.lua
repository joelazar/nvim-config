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
		lazy = true,
		-- event = "BufReadPost", -- TODO - this doesn't work
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- Open files from terminal window in the same neovim instance
	{
		"samjwill/nvim-unception",
		event = "VeryLazy",
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
		event = "BufReadPost",
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
		config = { auto_preview = false, auto_fold = true, auto_close = true },
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

	-- HTML/JS
	{
		"turbio/bracey.vim",
		ft = "html",
		build = 'sh -c "npm install --prefix server"',
	},

	-- Enhanced movement plugin
	{
		"phaazon/hop.nvim",
		config = true,
		event = "VeryLazy",
	},

	-- Enhanced folds
	{
		"kevinhwang91/nvim-ufo",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype)
					return { "treesitter", "indent" }
				end,
			})
		end,
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPre",
	},

	-- Scrollbar for Neovim
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
		event = "BufReadPre",
	},

	-- Task runner for Neovim
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
		cmd = { "OverseerRun", "OverseerRestartLast", "OverseerToggle" },
	},

	-- Highlight function arguments
	{
		"m-demare/hlargs.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("hlargs").setup()
		end,
		event = "BufReadPre",
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

	-- Add/change/delete surrounding delimiter pairs
	{
		"kylechui/nvim-surround",
		version = "*",
		config = true,
		event = "VeryLazy",
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

	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				keymaps = {
					close = { "<C-c>", "<Esc>" },
					yank_last = "<C-y>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					toggle_settings = "<C-o>",
					new_session = "<C-n>",
					cycle_windows = "<C-m>",
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTEditWithInstructions",
		},
	},
}
