return {
	"CopilotC-Nvim/CopilotChat.nvim",
	opts = {},
	-- sudo luarocks install --lua-version 5.1 tiktoken_core
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	branch = "canary",
	cmd = {
		"CopilotChat",
		"CopilotChatOpen",
		"CopilotChatClose",
		"CopilotChatToggle",
		"CopilotChatReset",
		"CopilotChatSave",
		"CopilotChatLoad",
		"CopilotChatDebugInfo",
	},
	keys = {
		{ "<leader>cco", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open" },
		{ "<leader>ccc", "<cmd>CopilotChatClose<cr>", desc = "CopilotChat - Close" },
		{ "<leader>cct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
		{ "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
		{
			"<leader>ccr",
			"<cmd>CopilotChatReset<cr>",
			desc = "CopilotChat - Reset",
		},
		{
			"<leader>ccD",
			"<cmd>CopilotChatDebugInfo<cr>",
			desc = "CopilotChat - Debug info",
		},
		{
			"<leader>cch",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.help_actions())
			end,
			desc = "CopilotChat - Help actions",
		},
		{
			"<leader>ccp",
			function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			end,
			desc = "CopilotChat - Prompt actions",
		},
		{
			"<leader>ccm",
			"<cmd>CopilotChatCommit<cr>",
			desc = "CopilotChat - Generate commit message for all changes",
		},
		{
			"<leader>ccM",
			"<cmd>CopilotChatCommitStaged<cr>",
			desc = "CopilotChat - Generate commit message for staged changes",
		},
		{
			"<leader>cci",
			function()
				local input = vim.fn.input("Ask Copilot: ")
				if input ~= "" then
					vim.cmd("CopilotChat " .. input)
				end
			end,
			desc = "CopilotChat - Ask input",
		},
		-- Generate commit message based on the git diff
		-- Quick chat with Copilot
		{
			"<leader>ccq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					vim.cmd("CopilotChatBuffer " .. input)
				end
			end,
			desc = "CopilotChat - Quick chat",
		},

		-- Visual mode
		{
			"<leader>ccp",
			":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
			mode = "x",
			desc = "CopilotChat - Prompt actions",
		},
		{
			"<leader>ccv",
			":CopilotChatVisual",
			mode = "x",
			desc = "CopilotChat - Open in vertical split",
		},
		{
			"<leader>cci",
			":CopilotChatInline<cr>",
			mode = "x",
			desc = "CopilotChat - Inline chat",
		},
	},
}
