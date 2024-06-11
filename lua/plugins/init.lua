return {
	-- Useful lua function collection
	"nvim-lua/plenary.nvim",

	-- Devicons
	"nvim-tree/nvim-web-devicons",

	-- Swap parameters easier
	{
		"mizlan/iswap.nvim",
		cmd = { "ISwap", "ISwapNode", "ISwapWith", "ISwapNodeWith", "IMove" },
	},

	-- Better % navigation
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = "nvim-treesitter/nvim-treesitter",
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
		event = "VeryLazy",
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

	-- Nicer diagnostics
	{
		"folke/trouble.nvim",
		opts = {
			auto_preview = true,
			auto_close = true,
		},
		cmd = { "Trouble" },
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
		config = function()
			require("overseer").setup()

			vim.api.nvim_create_user_command("OverseerRestartLast", function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end, {})
		end,
		cmd = { "OverseerRun", "OverseerToggle", "OverseerRestartLast" },
	},

	-- Highlight function arguments
	{
		"m-demare/hlargs.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
		event = { "BufReadPre", "BufNewFile" },
	},

	-- Quick annotation generator
	{
		"danymat/neogen",
		opts = { snippet_engine = "nvim" },
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
	},

	-- Change strings to template string on the fly
	{
		"axelvc/template-string.nvim",
		opts = {
			remove_template_string = true,
		},
		ft = {
			"html",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
	},

	-- Refactoring library based off the Refactoring book by Martin Fowler
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {},
	},

	-- Hightlight active code
	{ "folke/twilight.nvim", cmd = { "Twilight" } },

	-- Enhanve native comments of NeoVim
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Virtual environment selector for python
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope.nvim",
		},
		branch = "regexp",
		opts = {},
		cmd = "VenvSelect",
	},

	-- Session management
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

	-- Running custom functions on nodes
	{
		"ckolkey/ts-node-action",
		cmd = { "NodeAction", "NodeActionDebug" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		keys = { { "<C-t>", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" } },
	},

	-- DevDocs integration
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		build = ":DevdocsUpdateAll",
		opts = {},
		cmd = {
			"DevdocsFetch",
			"DevdocsInstall",
			"DevdocsUninstall",
			"DevdocsOpen",
			"DevdocsOpenFloat",
			"DevdocsOpenCurrent",
			"DevdocsOpenCurrentFloat",
			"DevdocsUpdate",
			"DevdocsUpdateAll",
		},
	},

	-- Better quickfix list
	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	-- Change text case easily
	{
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = { { "ga.", mode = { "n", "v" }, "<cmd>TextCaseOpenTelescope<CR>", desc = "Telescope text-case" } },
		cmd = { "TextCaseOpenTelescope" },
	},

	-- Measure the time spent on projects
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
	},

	-- Autodetect indentation
	{
		"nmac427/guess-indent.nvim",
		opts = {
			auto_cmd = true,
			override_editorconfig = false,
			filetype_exclude = {
				"netrw",
				"tutor",
			},
			buftype_exclude = {
				"help",
				"nofile",
				"terminal",
				"prompt",
			},
		},
		event = { "BufRead", "BufNewFile" },
	},

	-- Autopairs for neovim
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Cypher syntax highlighting
	{ "memgraph/cypher.vim", ft = { "cypher", "cql", "cyp" } },

	-- Lazygit integration
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>G", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- Rust plugin
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		lazy = false, -- this plugin already lazy loads
	},

	-- Git blame in Neovim
	{
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup()
		end,
		cmd = "BlameToggle",
	},

	-- Coverage for neovim
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			lang = {
				python = {
					-- ignore errors for now
					coverage_command = "coverage json --fail-under=0 -i -q -o -",
				},
			},
		},
		config = true,
		cmd = {
			"Coverage",
			"CoverageLoad",
			"CoverageShow",
			"CoverageSummary",
			"CoverageToggle",
		},
	},
}
