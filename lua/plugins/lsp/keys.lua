local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		["<C-k>"] = { "<cmd>Lspsaga hover_doc<CR>", "Signature Help", mode = { "n", "i" } },
		["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Signature Help" },
		["gk"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help - builtin lsp" },

		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>", "Next Diagnostic" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next({ float = false })<cr><CR>", "Prev Diagnostic" },
		["[e"] = {
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR, float = false})<CR>",
			"Next Error",
		},
		["]e"] = {
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR, float = false})<CR>",
			"Prev Error",
		},
		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
		["gD"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
		["gr"] = { "<cmd>Lspsaga lsp_finder<CR>", "Lspsaga finder" },
		["gi"] = { "<cmd>Lspsaga implement<CR>", "Go to implementation" },
		["gR"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
		["gT"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition" },
	}

	wk.register(keymap)
end

return M
