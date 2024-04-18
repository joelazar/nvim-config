local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",

	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	"CopilotC-Nvim/CopilotChat.nvim",
	opts = {
		mappings = {
			submit_prompt = {
				normal = "<CR>",
				insert = "<C-CR>",
			},
		},
		prompts = prompts,
	},
	config = function(_, opts)
		local chat = require("CopilotChat")
		local select = require("CopilotChat.select")

		-- Override the git prompts message
		opts.prompts.Commit = {
			prompt = "Write commit message for the change with commitizen convention",
			selection = select.gitdiff,
		}
		opts.prompts.CommitStaged = {
			prompt = "Write commit message for the change with commitizen convention",
			selection = function(source)
				return select.gitdiff(source, true)
			end,
		}

		chat.setup(opts)

		vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
			chat.ask(args.args, { selection = select.visual })
		end, { nargs = "*", range = true })

		-- Inline chat with Copilot
		vim.api.nvim_create_user_command("CopilotChatInline", function(args)
			chat.ask(args.args, {
				selection = select.visual,
				window = {
					layout = "float",
					relative = "cursor",
					width = 1,
					height = 0.4,
					row = 1,
				},
			})
		end, { nargs = "*", range = true })
	end,
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
		-- User commands
		"CopilotChatInline",
		"CopilotChatVisual",
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
		{
			"<leader>ccq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
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
