return {
	formatCommand = 'prettierd "${INPUT}"',
	formatStdin = true,
	env = {
		string.format("PRETTIERD_DEFAULT_CONFIG=%s", vim.fn.expand("~/.prettierrc.json")),
	},
}
