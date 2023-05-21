return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			yaml = true,
			markdown = true,
			gitcommit = true,
			gitrebase = true,
			hgcommit = false,
			help = false,
			svn = false,
			cvs = false,
			["."] = false,
			fish = function()
				if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%..*") then
					return false
				end
				return true
			end,
			sh = function()
				if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%..*") then
					return false
				end
				return true
			end,
		},
	},
}
