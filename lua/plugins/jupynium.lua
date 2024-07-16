return {
	"kiyoon/jupynium.nvim",
	build = "pip3 install --user --break-system-packages .",
	config = function()
		vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
			pattern = { "*.ju.*" },
			callback = function(event)
				local buf_id = event.buf
				local wk = require("which-key")
				wk.add({ mode = { "n", "v" }, buffer = buf_id, { "<leader>j", desc = "Jupynium" } })

				vim.keymap.set(
					{ "n", "x" },
					"<space>jx",
					"<cmd>JupyniumExecuteSelectedCells<CR>",
					{ buffer = buf_id, desc = "Jupynium execute selected cells" }
				)
				vim.keymap.set(
					{ "n", "x" },
					"<space>jc",
					"<cmd>JupyniumClearSelectedCellsOutputs<CR>",
					{ buffer = buf_id, desc = "Jupynium clear selected cells" }
				)
				vim.keymap.set(
					{ "n" },
					"<space>jK",
					"<cmd>JupyniumKernelHover<cr>",
					{ buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
				)
				vim.keymap.set(
					{ "n", "x" },
					"<space>js",
					"<cmd>JupyniumScrollToCell<cr>",
					{ buffer = buf_id, desc = "Jupynium scroll to cell" }
				)
				vim.keymap.set(
					{ "n", "x" },
					"<space>jo",
					"<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
					{ buffer = buf_id, desc = "Jupynium toggle selected cell output scroll" }
				)
				vim.keymap.set(
					"",
					"<PageUp>",
					"<cmd>JupyniumScrollUp<cr>",
					{ buffer = buf_id, desc = "Jupynium scroll up" }
				)
				vim.keymap.set(
					"",
					"<PageDown>",
					"<cmd>JupyniumScrollDown<cr>",
					{ buffer = buf_id, desc = "Jupynium scroll down" }
				)
			end,
			group = vim.api.nvim_create_augroup("vimrc_jupynium", { clear = true }),
		})
	end,
	ft = "python",
}
