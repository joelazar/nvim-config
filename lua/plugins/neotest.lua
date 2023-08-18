return {
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
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
				require("neotest-jest"),
				require("neotest-go"),
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					vim.cmd("Trouble quickfix")
				end,
			},
		})
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)
	end,
}
