local M = {}

M.setup = function()
    local present1, cmp = pcall(require, "cmp")
    local present2, lspkind = pcall(require, "lspkind")
    local present3, luasnip = pcall(require, "luasnip")

    if not (present1 and present2 and present3) then return end

    lspkind.init()

    cmp.setup({
        mapping = {
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close()
            }),
            ["<CR>"] = cmp.mapping.confirm {select = true},
            ["<C-y>"] = cmp.config.disable,
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {"i", "s"}),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump_prev()
                else
                    fallback()
                end
            end, {"i", "s"})
        },

        sources = {
            {name = "nvim_lua"}, {name = "nvim_lsp"}, {name = "path"},
            {name = "luasnip"}, {name = "buffer", keyword_length = 3}
        },

        snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},

        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[lua]",
                    path = "[path]",
                    luasnip = "[snip]"
                }
            }
        },

        experimental = {native_menu = false, ghost_text = true}
    })

end

return M
