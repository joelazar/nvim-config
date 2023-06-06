local M = {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
		"haydenmeade/neotest-jest",
	},
	ft = {
		"go",
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"python",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
	},
}

M.config = function()
	require("neotest").setup({
		adapters = {
			require("neotest-python"),
			require("neotest-jest"),
			require("neotest-go"),
		},
		output = { open_on_run = true },
		quickfix = {
			open = function()
				vim.cmd("Trouble quickfix")
			end,
		},
	})
end

return M
