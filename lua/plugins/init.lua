return {
	-- Useful lua function collection
	"nvim-lua/plenary.nvim",

	-- Devicons
	"nvim-tree/nvim-web-devicons",

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
		"folke/lsp-trouble.nvim",
		opts = { auto_preview = false, auto_fold = false, auto_close = true },
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
		opts = {},
		cmd = { "OverseerRun", "OverseerToggle" },
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
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
	},

	-- Change strings to template string on the fly in jsx/tsx
	{
		"axelvc/template-string.nvim",
		opts = {
			remove_template_string = true, -- remove backticks when there are no template strings
		},
		ft = {
			"html",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"python",
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

	{ "folke/twilight.nvim", cmd = { "Twilight" } },

	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user --break-system-packages .",
		ft = "python",
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},

	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		opts = { dap_enabled = true },
		cmd = { "VenvSelect" },
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
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		keys = { { "<C-t>", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" } },
	},

	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("wildfire").setup({
				filetype_exclude = {
					"PlenaryTestPopup",
					"TelescopePrompt",
					"chatgpt",
					"checkhealth",
					"dap-repl",
					"help",
					"lspinfo",
					"man",
					"neotest-output",
					"neotest-output-panel",
					"neotest-summary",
					"nnn",
					"notify",
					"qf",
					"spectre_panel",
					"startuptime",
					"tsplayground",
				},
			})
		end,
	},

	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		cmd = { "Wtf", "WtfSearch" },
		keys = {
			{
				"gw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},

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

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = { { "ga.", mode = { "n", "v" }, "<cmd>TextCaseOpenTelescope<CR>", desc = "Telescope text-case" } },
		cmd = { "TextCaseOpenTelescope" },
	},

	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
	},

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

	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				layout = {
					min_width = 30,
					default_direction = "right",
					placement = "edge",
				},
				highlight_on_hover = true,
				autojump = true,
				manage_folds = true,
				show_guides = true,
			})
			require("telescope").load_extension("aerial")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialClose",
			"AerialNavOpen",
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{ "memgraph/cypher.vim", ft = { "cypher", "cql", "cyp" } },
}
