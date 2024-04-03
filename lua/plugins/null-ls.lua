return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
			sources = {
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.code_actions.impl,

				null_ls.builtins.diagnostics.fish,
				-- null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),

				-- null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.shfmt.with({
					extra_args = { "-i", "2", "-s", "-ci" },
				}),
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				null_ls.builtins.formatting.stylua,

				null_ls.builtins.hover.dictionary,
			},
			on_attach = function(client, buffer)
				require("plugins.lsp.keys").setup(buffer)
				require("plugins.lsp.format").on_attach(client, buffer)
			end,
		})
	end,
}
