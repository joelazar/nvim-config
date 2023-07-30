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
		config = {
			one_per = {
				kitty = false,
			},
		},
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

	{ "folke/twilight.nvim", cmd = { "Twilight" } },
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",

		keys = {
			{
				"<A-h>",
				function()
					require("smart-splits").resize_left()
				end,
				desc = "Resize left",
				mode = "n",
			},
			{
				"<A-j>",
				function()
					require("smart-splits").resize_down()
				end,
				desc = "Resize down",
				mode = "n",
			},
			{
				"<A-k>",
				function()
					require("smart-splits").resize_up()
				end,
				desc = "Resize up",
				mode = "n",
			},
			{
				"<A-l>",
				function()
					require("smart-splits").resize_right()
				end,
				desc = "Resize right",
				mode = "n",
			},
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				desc = "Move cursor left",
				mode = "n",
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				desc = "Move cursor down",
				mode = "n",
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				desc = "Move cursor up",
				mode = "n",
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				desc = "Move cursor right",
				mode = "n",
			},
			{
				"<C-A-h>",
				function()
					require("smart-splits").swap_buf_left()
				end,
				desc = "Swap buffer left",
				mode = "n",
			},
			{
				"<C-A-j>",
				function()
					require("smart-splits").swap_buf_down()
				end,
				desc = "Swap buffer down",
				mode = "n",
			},
			{
				"<C-A-k>",
				function()
					require("smart-splits").swap_buf_up()
				end,
				desc = "Swap buffer up",
				mode = "n",
			},
			{
				"<C-A-l>",
				function()
					require("smart-splits").swap_buf_right()
				end,
				desc = "Swap buffer right",
				mode = "n",
			},
		},
	},

	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user --break-system-packages .",
		ft = "python",
	},

	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		config = true,
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>Qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>Ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>Qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
	},

	{
		"ckolkey/ts-node-action",
		cmd = { "NodeAction", "NodeActionDebug" },
		dependencies = { "nvim-treesitter" },
		opts = {},
	},
}
