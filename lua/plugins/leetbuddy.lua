return {
	"Dhanus3133/LeetBuddy.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("leetbuddy").setup({})
	end,
	cmd = { "LBQuestions", "LBQuestion", "LBReset", "LBTest", "LBSubmit" },
	keys = {
		{ "<leader>Lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
		{ "<leader>Ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
		{ "<leader>Lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
		{ "<leader>Lt", "<cmd>LBTest<cr>", desc = "Run Code" },
		{ "<leader>Ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
	},
}
