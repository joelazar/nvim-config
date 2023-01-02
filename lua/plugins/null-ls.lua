local M = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
}

M.config = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.code_actions.eslint_d,
			null_ls.builtins.code_actions.shellcheck,

			null_ls.builtins.completion.spell,

			null_ls.builtins.diagnostics.actionlint,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.diagnostics.fish,
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.diagnostics.pylint,
			null_ls.builtins.diagnostics.shellcheck,

			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.fish_indent,
			null_ls.builtins.formatting.isort,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.sqlfluff,
			null_ls.builtins.formatting.stylua,

			null_ls.builtins.hover.dictionary,
		},
	})
end

return M
