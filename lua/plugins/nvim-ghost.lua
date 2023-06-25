local M = {
	"subnut/nvim-ghost.nvim",
	lazy = false,
	config = function()
		vim.g.nvim_ghost_super_quiet = 1
		vim.cmd([[
				augroup nvim_ghost_user_autocommands
					au User *github.com,*stackoverflow.com,*reddit.com setfiletype markdown
					au User *github.com,*stackoverflow.com,*reddit.com let b:copilot_enabled=1
					au User *github.com,*stackoverflow.com,*reddit.com setlocal spell
				augroup END
			]])
	end,
}

return M
