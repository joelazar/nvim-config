local M = {}

M.org_imports = function(wait_ms)
	local codeaction = require("go.lsp").codeaction
	codeaction("", "source.organizeImports", wait_ms)
	vim.lsp.buf.formatting_seq_sync(nil, wait_ms)
end

M.goimport = function()
	M.org_imports(1000)
	return
end

M.config = {
	goimport = "gopls", -- if set to 'gopls' will use golsp format
	gofmt = "gopls", -- if set to gopls will use golsp format
	max_line_len = 120,
	tag_transform = false,
	test_dir = "",
	comment_placeholder = "   ",
	lsp_cfg = false, -- false: use your own lspconfig
	lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
	lsp_on_attach = false, -- use on_attach from go.nvim
	dap_debug = true,
	lsp_codelens = true,
}

M.setup = function()
	local status_ok, go = pcall(require, "go")
	if not status_ok then
		return
	end
	go.setup(M.config)
end

return M
