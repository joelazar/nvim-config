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
		config = function()
			local overseer = require("overseer")
			overseer.setup()
			vim.api.nvim_create_user_command("OverseerRestartLast", function()
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end, {})
		end,
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
		keys = { { "<C-e>", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" } },
	},

	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("wildfire").setup()
		end,
	},

	{
		"gaoDean/autolist.nvim",
		ft = { "markdown" },
		config = function()
			require("autolist").setup()

			vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
			vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
			-- vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
			vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
			-- vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
			vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

			vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
			vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
			vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
			vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
		end,
	},
}
