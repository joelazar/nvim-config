local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
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
		{ "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
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
	local luasnip = require("luasnip")

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	cmp.setup({
		mapping = {
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<C-j>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
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
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "buffer", keyword_length = 3 },
			{ name = "luasnip", keyword_length = 2 },
			{ name = "nvim_lua" },
			{ name = "fish" },
			{ name = "path" },
			{
				name = "look",
				keyword_length = 5,
				max_item_count = 5,
				option = { convert_case = true, loud = true },
			},
			{ name = "calc" },
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
				symbol_map = { Copilot = "" },
			}),
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,

				-- Below is the default comparitor list and order for nvim-cmp
				cmp.config.compare.offset,
				-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
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
			disallow_partial_fuzzy_matching = false,
			disallow_partial_matching = false,
			disallow_prefix_unmatching = false,
		},
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
			{ name = "fuzzy_buffer" },
		},
	})
end

return M
