local M = {}

function M.setup(buffer)
	local wk = require("which-key")

	local keymap = {
		buffer = buffer,
		{
			{ "K", "<cmd> lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
			{ "[d", "<cmd> lua vim.diagnostic.goto_prev()<cr>", desc = "Diagnostic backward" },
			{
				"[e",
				"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>",
				desc = "Error backward",
			},
			{ "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Diagnostic forward" },
			{
				"]e",
				"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>",
				desc = "Error forward",
			},
			{ "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto declaration" },
			{
				"gd",
				'<cmd>lua require("telescope.builtin").lsp_definitions({ reuse_win = true })<cr>',
				desc = "Goto definition",
			},
			{ "gdhas", desc = "definition" },
			{
				"gi",
				'<cmd>lua require("telescope.builtin").lsp_implementations({ reuse_win = true })<cr>',
				desc = "Goto implementation",
			},
			{ "gk", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature help" },
			{ "gkhas", desc = "signatureHelp" },
			{
				"gr",
				'<cmd>lua require("telescope.builtin").lsp_references({ fname_width = 80 })<cr>',
				desc = "References",
			},
			{
				"gt",
				'<cmd>lua require("telescope.builtin").lsp_type_definitions({ reuse_win = true })<cr>',
				desc = "Goto t[y]pe definition",
			},
			{ "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature help", mode = "i" },
			{ "<c-k>has", desc = "signatureHelp", mode = "i" },
		},
	}

	wk.add(keymap)
end

return M
