local M = {}

M.setup = function()
	local present1, cmp = pcall(require, "cmp")
	local present2, lspkind = pcall(require, "lspkind")
	local present3, luasnip = pcall(require, "luasnip")

	if not (present1 and present2 and present3) then
		return
	end

	lspkind.init()

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
				name = "tmux",
				max_item_count = 5,
				option = { all_panes = true },
				keyword_length = 5,
			},
			{
				name = "look",
				keyword_length = 5,
				max_item_count = 5,
				option = { convert_case = true, loud = true },
			},
			{ name = "calc" },
		},

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				menu = {
					buffer = "[buf]",
					look = "[look]",
					luasnip = "[snip]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[lua]",
					path = "[path]",
					tmux = "[tmux]",
					calc = "[calc]",
				},
			}),
		},

		experimental = { native_menu = false, ghost_text = true },
	})

	cmp.setup.cmdline("/", {
		sources = cmp.config.sources({ { name = "buffer", keyword_length = 3 } }),
	})

	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline", max_item_count = 20, keyword_length = 3 },
		}),
	})
end

return M
