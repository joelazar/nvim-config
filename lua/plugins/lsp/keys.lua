local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help", mode = { "n", "i" } },
		["K"] = { "<cmd>Lspsaga hover_doc<cr>", "Signature Help" },
		["[d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
		["]d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
		["[e"] = {
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
			"Next Error",
		},
		["]e"] = {
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
			"Prev Error",
		},
		["gr"] = { "<cmd>Lspsaga lsp_finder<cr>", "Lspsaga finder" },
		["gd"] = { "<cmd>Lspsaga goto_definition<cr>", "Go to definition" },
		["gD"] = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
		["gt"] = { "<cmd>Lspsaga goto_type_definition<cr>", "Go to type definition" },
		["gT"] = { "<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition" },
	}

	wk.register(keymap)
end

return M
