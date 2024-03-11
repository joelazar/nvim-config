return {
	"CopilotC-Nvim/CopilotChat.nvim",
	opts = {
		debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
	},
	-- sudo luarocks install --lua-version 5.1 tiktoken_core
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	branch = "canary",
	cmd = {
		"CopilotChatClose",
		"CopilotChatDebugInfo",
		"CopilotChatOpen",
		"CopilotChatReset",
		"CopilotChatToggle",
	},
	keys = {
		{ "<leader>cco", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open" },
		{ "<leader>ccc", "<cmd>CopilotChatClose<cr>", desc = "CopilotChat - Close" },
		{ "<leader>cct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
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
	},
}
