local M = {
	"NTBBloodbath/rest.nvim",
	config = {
		-- Open request results in a horizontal split
		result_split_horizontal = false,
		-- Skip SSL verification, useful for unknown certificates
		skip_ssl_verification = false,
		-- Highlight request on run
		highlight = { enabled = true, timeout = 1000 },
		-- Jump to request line on run
		jump_to_request = false,
	},
	ft = { "http" },
}

return M
