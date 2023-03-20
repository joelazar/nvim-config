local M = {
	"github/copilot.vim",
	event = "VeryLazy",
}

M.config = function()
	vim.g.copilot_filetypes = {
		["*"] = false,
		-- ["markdown"] = true,
		bash = true,
		c = true,
		cpp = true,
		go = true,
		html = true,
		javascript = true,
		javascriptreact = true,
		json = true,
		lua = true,
		python = true,
		rust = true,
		sh = true,
		terraform = true,
		toml = true,
		typescript = true,
		typescriptreact = true,
		vim = true,
		yaml = true,
	}
	vim.cmd([[
      imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
    ]])
end

return M
