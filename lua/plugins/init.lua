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

	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				welcome_message = "",
				keymaps = {
					close = { "<C-c>" },
					submit = "<C-Enter>",
					yank_last = "<C-y>",
					yank_last_code = "<C-k>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					toggle_settings = "<C-o>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					-- in the Sessions pane
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
				},
				-- openai_params = {
				-- 	model = "gpt-3.5-turbo",
				-- 	-- model = "gpt-4",
				-- 	-- model = "gpt-4-32k",
				-- 	frequency_penalty = 0,
				-- 	presence_penalty = 0,
				-- 	max_tokens = 300,
				-- 	temperature = 0,
				-- 	top_p = 1,
				-- 	n = 1,
				-- },
				actions_paths = { "~/.config/nvim/custom_actions.json" },
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
			"ChatGPTRun",
			"ChatGPTRunCustomCodeAction",
		},
		pin = "a18b19cbb3e20b91d7bf9b662bf29dd66158112c",
	},

	{
		"subnut/nvim-ghost.nvim",
		lazy = false,
		pin = "967be0880b2ccbf338990149f14a1f873a9054fa",
		-- cmd = { "GhostTextStart" },
		config = function()
			vim.g.nvim_ghost_super_quiet = 1
			-- vim.g.nvim_ghost_autostart = 0
			vim.cmd([[
				augroup nvim_ghost_user_autocommands
					au User *github.com,*stackoverflow.com,*reddit.com setfiletype markdown
					au User *github.com,*stackoverflow.com,*reddit.com let b:copilot_enabled=1
				augroup END
			]])
		end,
	},
}
