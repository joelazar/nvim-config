local M = {}

M.setup = function()
	local status_ok, neotest = pcall(require, "neotest")
	if not status_ok then
		return
	end

	neotest.setup({
		adapters = {
			require("neotest-python"),
			require("neotest-jest")({
				jestCommand = "yarn test --",
				-- jestConfigFile = "jest.config.js",
				-- env = { CI = true },
				cwd = function(path)
					return vim.fn.getcwd()
				end,
			}),
			require("neotest-go"),
		},
	})
end

return M
