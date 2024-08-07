return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-python",
		"haydenmeade/neotest-jest",
		"folke/trouble.nvim",
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
				-- require("neotest-golang"),
				["neotest-golang"] = {
					-- Here we can set options for neotest-golang, e.g.
					-- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
					dap_go_enabled = true, -- requires leoluz/nvim-dap-go
				},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					require("trouble").open({ mode = "quickfix", focus = false })
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
