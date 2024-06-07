local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"octaltree/cmp-look",
		"onsails/lspkind-nvim",
		"ray-x/cmp-treesitter",
		{
			"garymjr/nvim-snippets",
			opts = {
				friendly_snippets = true,
				global_snippets = { "all", "global" },
			},
			dependencies = { "rafamadriz/friendly-snippets" },
			keys = {
				{
					"<Tab>",
					function()
						return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
					end,
					expr = true,
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<S-Tab>",
					function()
						return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<Tab>"
					end,
					expr = true,
					silent = true,
					mode = { "i", "s" },
				},
			},
		},
		{ "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
		{ "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" } },
		{
			"zbirenbaum/copilot-cmp",
			dependencies = "copilot.lua",
			opts = {},
			config = function(_, opts)
				local copilot_cmp = require("copilot_cmp")
				copilot_cmp.setup(opts)
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client.name == "copilot" then
							copilot_cmp._on_insert_enter({})
						end
					end,
				})
			end,
		},
	},
}

M.config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local utils = require("config.utils")

	cmp.setup({
		mapping = {
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-CR>"] = function(fallback)
				cmp.abort()
				fallback()
			end,
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = function(fallback)
				if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
					utils.create_undo()
					if cmp.confirm({ select = false }) then
						return
					end
				end
				return fallback()
			end,
			["<S-CR>"] = function(fallback)
				if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
					utils.create_undo()
					if cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }) then
						return
					end
				end
				return fallback()
			end,
			["<C-j>"] = function(fallback)
				if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
					utils.create_undo()
					if cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }) then
						return
					end
				end
				return fallback()
			end,
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		sources = {
			{ name = "git" },
			{ name = "jupynium", priority = 1000 },
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "treesitter" },
			{ name = "fuzzy_buffer" },
			{ name = "buffer", keyword_length = 3 },
			{ name = "snippets" },
			{ name = "path" },
			{
				name = "look",
				keyword_length = 3,
				max_item_count = 10,
				option = { convert_case = true, loud = true },
			},
			{ name = "calc" },
		},
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				symbol_map = { Copilot = "", Git = "", Comment = "", String = "󰉿" },
			}),
		},

		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,

				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,

				cmp.config.compare.recently_used,
				cmp.config.compare.locality,

				-- copied from cmp-under, but I don't think I need the plugin for this.
				-- I might add some more of my own.
				function(entry1, entry2)
					local _, entry1_under = entry1.completion_item.label:find("^_+")
					local _, entry2_under = entry2.completion_item.label:find("^_+")
					entry1_under = entry1_under or 0
					entry2_under = entry2_under or 0
					if entry1_under > entry2_under then
						return false
					elseif entry1_under < entry2_under then
						return true
					end
				end,

				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		experimental = {
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},
		matching = {
			disallow_fuzzy_matching = false,
			disallow_fullfuzzy_matching = false,
			disallow_partial_fuzzy_matching = true,
			disallow_partial_matching = false,
			disallow_prefix_unmatching = false,
		},
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "fuzzy_buffer" },
		},
	})

	require("cmp_git").setup({ filetypes = { "gitcommit", "octo", "markdown" } })
end

return M
