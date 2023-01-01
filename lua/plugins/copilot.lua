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
		lua = true,
		python = true,
		rust = true,
		sh = true,
		terraform = true,
		typescript = true,
		typescriptreact = true,
	}
	vim.cmd([[
      imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
    ]])
end

return M
