local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition", has = "definition" },
		["gr"] = { "<cmd>Telescope lsp_references<cr>", "References" },
		["gD"] = { "<cmd>vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
		["gi"] = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
		["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto T[y]pe Definition" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
		["gk"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help", has = "signatureHelp" },
		["<c-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", mode = "i", "Signature Help", has = "signatureHelp" },
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Next Diagnostic" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr><CR>", "Prev Diagnostic" },
		["[e"] = {
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
			"Next Error",
		},
		["]e"] = {
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
			"Prev Error",
		},
	}

	wk.register(keymap)
end

return M
