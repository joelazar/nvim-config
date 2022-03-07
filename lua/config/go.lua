local M = {}

M.config = {
	goimport = "gopls", -- if set to 'gopls' will use golsp format
	gofmt = "gopls", -- if set to gopls will use golsp format
	tag_transform = false,
	test_dir = "",
	comment_placeholder = "   ",
	lsp_cfg = false, -- false: use your own lspconfig
	lsp_on_attach = false, -- use on_attach from go.nvim
	dap_debug = true,
}

M.setup = function()
	local status_ok, go = pcall(require, "go")
	if not status_ok then
		return
	end
	go.setup(M.config)
end

return M
