local M = {
	"ray-x/go.nvim",
	ft = { "go", "gomod" },
	config = {
		test_dir = "",
		comment_placeholder = "   ",
		lsp_cfg = false, -- false: use your own lspconfig
		lsp_on_attach = nil, -- use on_attach from go.nvim
		dap_debug = true,
	},
}

return M
