local M = {}

M.setup = function()
	local status_ok, null_ls = pcall(require, "null-ls")
	if not status_ok then
		return
	end

	null_ls.setup({
		sources = {
			null_ls.builtins.code_actions.gitsigns,
			null_ls.builtins.code_actions.shellcheck,

			null_ls.builtins.completion.spell,

			null_ls.builtins.diagnostics.actionlint,
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.diagnostics.fish,
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.diagnostics.golangci_lint,
			null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.diagnostics.pylint,
			null_ls.builtins.diagnostics.shellcheck,

			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.fish_indent,
			null_ls.builtins.formatting.isort,
			null_ls.builtins.formatting.pg_format,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,

			null_ls.builtins.hover.dictionary,
		},
	})
end

return M
