return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.code_actions.shellcheck,

				null_ls.builtins.diagnostics.fish,
				-- null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),

				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				null_ls.builtins.formatting.stylua,

				null_ls.builtins.hover.dictionary,
			},
		})
	end,
}
