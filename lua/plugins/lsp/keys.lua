local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		["gd"] = {
			'<cmd>lua require("telescope.builtin").lsp_definitions({ reuse_win = true })<cr>',
			"Goto Definition",
			has = "definition",
		},
		["gr"] = {
			'<cmd>lua require("telescope.builtin").lsp_references({ fname_width = 80 })<cr>',
			"References",
		},
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
		["gi"] = {
			'<cmd>lua require("telescope.builtin").lsp_implementations({ reuse_win = true })<cr>',
			"Goto Implementation",
		},
		["gt"] = {
			'<cmd>lua require("telescope.builtin").lsp_type_definitions({ reuse_win = true })<cr>',
			"Goto T[y]pe Definition",
		},
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
		["gk"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help", has = "signatureHelp" },
		["<c-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", mode = "i", "Signature Help", has = "signatureHelp" },
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
		["[e"] = {
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>",
			"Prev Error",
		},
		["]e"] = {
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>",
			"Next Error",
		},
	}

	wk.register(keymap)
end

return M
