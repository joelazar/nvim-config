return {
	"subnut/nvim-ghost.nvim",
	lazy = false,
	-- until this issue (https://github.com/subnut/nvim-ghost.nvim/issues/59) is resolved
	-- we have to install the requirements manually
	-- in the plugin directory:
	-- python -m pip install -r requirements.txt
	config = function()
		vim.g.nvim_ghost_super_quiet = 1
		vim.g.nvim_ghost_use_script = 1
		vim.g.nvim_ghost_python_executable = "/opt/homebrew/bin/python3"
		vim.cmd([[
				augroup nvim_ghost_user_autocommands
					au User *github.com,*stackoverflow.com,*reddit.com setfiletype markdown
					au User *github.com,*stackoverflow.com,*reddit.com let b:copilot_enabled=1
					au User *github.com,*stackoverflow.com,*reddit.com setlocal spell
				augroup END
			]])
	end,
}
