local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"dmitmel/cmp-cmdline-history",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-path",
		"mtoohey31/cmp-fish",
		"octaltree/cmp-look",
		"onsails/lspkind-nvim",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
}

M.config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")

	cmp.setup({
		mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<C-y>"] = cmp.config.disable,
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},

		sources = {
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "buffer", keyword_length = 3 },
			{
				name = "look",
				keyword_length = 5,
				max_item_count = 5,
				option = { convert_case = true, loud = true },
			},
			{ name = "calc" },
			{ name = "fish" },
			{ name = "emoji" },
		},

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				menu = {
					buffer = "[buf]",
					calc = "[calc]",
					emoji = "[emoji]",
					fish = "[fish]",
					look = "[look]",
					luasnip = "[snip]",
					nvim_lsp = "[lsp]",
					nvim_lua = "[lua]",
					path = "[path]",
				},
			}),
		},

		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,

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

		experimental = { ghost_text = true },
	})
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "cmdline" },
			{ name = "path" },
		},
	})
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
end

return M
