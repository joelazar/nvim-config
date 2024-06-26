local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		["gd"] = {
			'<cmd>lua require("telescope.builtin").lsp_definitions({ reuse_win = true })<cr>',
			"Goto definition",
			has = "definition",
		},
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto declaration" },
		["gr"] = {
			'<cmd>lua require("telescope.builtin").lsp_references({ fname_width = 80 })<cr>',
			"References",
		},
		["gi"] = {
			'<cmd>lua require("telescope.builtin").lsp_implementations({ reuse_win = true })<cr>',
			"Goto implementation",
		},
		["gt"] = {
			'<cmd>lua require("telescope.builtin").lsp_type_definitions({ reuse_win = true })<cr>',
			"Goto t[y]pe definition",
		},
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
		["gk"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help", has = "signatureHelp" },
		["<c-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", mode = "i", "Signature help", has = "signatureHelp" },
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Diagnostic backward" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Diagnostic forward" },
		["[e"] = {
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>",
			"Error backward",
		},
		["]e"] = {
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>",
			"Error forward",
		},
	}

	wk.register(keymap)
end

return M
