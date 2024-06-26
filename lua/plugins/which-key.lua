local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

M.config = function()
	local wk = require("which-key")

	local config = {
		setup = {
			layout = { align = "center" },
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		},
		vmappings = {
			["g"] = {
				name = "Git",
				["y"] = {
					'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
					"Copy link to clipboard",
				},
			},
			["l"] = {
				name = "LSP",
				["a"] = {
					"<cmd>lua vim.lsp.buf.code_action()<cr>",
					"Code action",
				},
			},
			["e"] = { ":SnipRun<cr>", "Execute (sniprun)" },
			["a"] = {
				name = "AI",
				["e"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
				["t"] = { "<cmd>Telescope gpt<CR>", "Telescope GPT" },
			},
			["b"] = { name = "Buffers" },
			["c"] = { name = "Copilot" },
			["r"] = {
				name = "Refactoring",
				["b"] = {
					"<Esc><Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
					"Extract block",
				},
				["f"] = {
					"<Esc><Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
					"Extract block to file",
				},
				["e"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>",
					"Extract function",
				},
				["F"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
					"Extract function to file",
				},
				["v"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
					"Extract variable",
				},
				["i"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
					"Inline variable",
				},
				["r"] = {
					"<cmd>lua require('refactoring').select_refactor()<CR>",
					"Select refactor",
				},
				["p"] = {
					"<cmd>lua require('refactoring').debug.print_var({normal = true})<CR>",
					"Print variable",
				},
			},
			["s"] = {
				name = "Search",
				["w"] = { "<cmd>Telescope grep_string<CR>", "Visual selection" },
			},
			["S"] = {
				name = "Search & Replace",
				["w"] = {
					"<esc><cmd>lua require('spectre').open_visual()<CR>",
					"Replace selection",
				},
			},
			["z"] = {
				name = "Obsidian",
				["l"] = { "<cmd>ObsidianLink<CR>", "Link a note" },
				["n"] = {
					function()
						local title = vim.fn.input("Title: ")
						if title ~= "" then
							vim.cmd("ObsidianLinkNew " .. title)
						end
					end,
					"Create new linked note (in current dir)",
				},
			},
		},
		mappings = {
			[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },

			["a"] = {
				name = "AI",
				["a"] = { "<cmd>ChatGPTActAs<cr>", "ChatGPT - Act as" },
				["e"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "ChatGPT - Edit with instruction" },
				["s"] = { "<cmd>ChatGPT<CR>", "ChatGPT - Session" },
				["t"] = { "<cmd>Telescope gpt<CR>", "ChatGPT - Custom actions" },
			},
			["c"] = { name = "Copilot" },
			["C"] = { "<cmd>Telescope neoclip<cr>", "Clipboard manager" },
			["f"] = { "<cmd>NnnExplorer<cr>", "nnn" },
			["F"] = { "<cmd>NnnExplorer %:p:h<cr>", "nnn (current buffer dir)" },
			["n"] = { "<cmd>NnnPicker<cr>", "nnn" },
			["N"] = { "<cmd>NnnPicker %:p:h<cr>", "nnn (current buffer dir)" },
			["q"] = { "<cmd>q!<cr>", "Quit" },
			["u"] = { "<cmd>Telescope undo<cr>", "Undotree" },
			["w"] = { "<cmd>w!<cr>", "Save" },
			["W"] = { "<cmd>lua require'config.utils'.sudo_write()<cr>", "Sudo save" },
			["b"] = {
				name = "Buffers",
				["F"] = {
					"<cmd>lua vim.lsp.buf.format({ async = true })<cr>",
					"Format buffer (LSP)",
				},
				["L"] = {
					"<cmd>BufferLineCloseLeft<cr>",
					"Close all buffers to the left",
				},
				["P"] = { "<cmd>BufferLineTogglePin<cr>", "Pin/Unpin buffer" },
				["R"] = {
					"<cmd>BufferLineCloseRight<cr>",
					"Close all buffers to the right",
				},
				["s"] = { "<cmd>Telescope buffers<cr>", "Search buffers" },
				["S"] = {
					name = "Sort buffers",
					["d"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort buffers automatically by directory" },
					["l"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort buffers automatically by language" },
				},
				["w"] = { "<cmd>BufferLineCloseOthers<cr>", "Close all but current buffer" },
				["W"] = { "<cmd>BufferLineGroupClose ungrouped<cr>", "Close all but pinned buffers" },
			},
			["d"] = {
				name = "Debug",
				b = {
					name = "Breakpoints",
					c = {
						"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
						"Breakpoint condition",
					},
					m = {
						"<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
						"Log point message",
					},
					t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
				},
				h = {
					name = "Hover",
					h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
					v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual hover" },
				},
				r = {
					name = "Repl",
					o = { "<cmd>lua require('dap').repl.toggle()<CR>", "Toggle" },
					l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run last" },
				},
				R = {
					"<cmd>lua require('dap').run_to_cursor()<CR>",
					"Run to cursor",
				},
				s = {
					name = "Step",
					c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
					v = { "<cmd>lua require('dap').step_over()<CR>", "Step over" },
					i = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
					o = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },
				},
				t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle" },
				u = {
					name = "UI",
					h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
					f = {
						"local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
						"Float",
					},
				},
			},
			["D"] = {
				name = "Devdocs",
				["o"] = { "<cmd>DevdocsOpen<cr>", "Open docs" },
				["c"] = { "<cmd>DevdocsOpenCurrent<cr>", "Open docs for current filetype" },
			},
			["P"] = {
				name = "Plugin manager",
				["m"] = { "<cmd>Lazy<cr>", "Lazy menu" },
				["r"] = { "<cmd>Lazy restore<cr>", "Lazy restore" },
				["s"] = { "<cmd>Lazy sync<cr>", "Lazy sync" },
				["u"] = { "<cmd>Lazy update<cr>", "Lazy update" },
			},
			["g"] = {
				name = "Git",
				["t"] = {
					name = "Telescope",
					["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
					["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
					["f"] = {
						"<cmd>Telescope git_bcommits<cr>",
						"Checkout commit (for current file)",
					},
					["s"] = { "<cmd>Telescope git_status<cr>", "Status" },
					["S"] = { "<cmd>Telescope git_stash<cr>", "Stash" },
				},
				["d"] = {
					name = "Diffview",
					["o"] = { "<cmd>DiffviewOpen<cr>", "Open" },
					["c"] = { "<cmd>DiffviewClose<cr>", "Close" },
					["h"] = { "<cmd>DiffviewFileHistory<cr>", "History" },
					["H"] = { "<cmd>DiffviewFileHistory %<cr>", "History for current file only" },
					["r"] = { "<cmd>DiffviewRefresh<cr>", "Refresh stats and entries" },
					["f"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle files panel" },
				},
				["y"] = {
					'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
					"Copy link to clipboard",
				},
				["q"] = {
					"<cmd>Gitsigns setqflist<cr>",
					"Trouble list with hunks",
				},
			},
			["l"] = {
				name = "LSP",
				["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
				["c"] = {
					name = "Codelens",
					["r"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run" },
					["d"] = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display" },
					["u"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Update" },
				},
				["d"] = { "<cmd>Trouble diagnostics toggle<cr>", "Workspace diagnostics (Trouble)" },
				["D"] = {
					"<cmd>Telescope diagnostics<cr>",
					"Workspace diagnostics (telescope)",
				},
				["i"] = { "<cmd>LspInfo<cr>", "Info" },
				["k"] = {
					"<cmd>lua vim.lsp.buf.hover()<cr>",
					"Toggle hover doc",
				},
				["l"] = {
					"<cmd>lua vim.diagnostic.open_float()<cr>",
					"Show line diagnostics",
				},
				["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				["s"] = {
					"<cmd>Telescope lsp_document_symbols<cr>",
					"Document symbols",
				},
				["S"] = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace symbols",
				},
				["t"] = {
					"<cmd>Trouble symbols toggle focus=false<cr>",
					"Document symbols (Trouble)",
				},
			},
			["o"] = {
				name = "Overseer",
				["l"] = { "<cmd>OverseerRestartLast<cr>", "Run last task" },
				["r"] = { "<cmd>OverseerRun<cr>", "List tasks in project" },
				["t"] = { "<cmd>OverseerToggle<cr>", "Toggle summary window" },
			},
			["s"] = {
				name = "Search",
				['"'] = { "<cmd>Telescope registers<cr>", "Registers" },
				["b"] = { "<cmd>Telescope vim_bookmarks all<cr>", "Bookmarks" },
				["B"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
				["c"] = { "<cmd>Telescope commands<cr>", "Commands" },
				["C"] = { "<cmd>Telescope colorscheme enable_preview=true<cr>", "Colorscheme" },
				["f"] = { "<cmd>Telescope find_files<cr>", "Files" },
				["h"] = { "<cmd>Telescope command_history<cr>", "Command history" },
				["H"] = { "<cmd>Telescope help_tags<cr>", "Help" },
				["j"] = { "<cmd>Telescope jumplist<cr>", "Jump list" },
				["l"] = { "<cmd>Telescope loclist<cr>", "Location list" },
				["L"] = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
				["k"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				["m"] = { "<cmd>Telescope marks<cr>", "Marks" },
				["M"] = { "<cmd>Telescope man_pages<cr>", "Man pages" },
				["o"] = { "<cmd>Telescope oldfiles<cr>", "Recently opened files" },
				["r"] = { "<cmd>Telescope resume<cr>", "Recent search" },
				["R"] = { "<cmd>Telescope registers<cr>", "Registers" },
				["p"] = { "<cmd>TodoTelescope<cr>", "TODO comments" },
				["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
				["s"] = { "<cmd>Telescope smart_open<cr>", "Smart open" },
				["t"] = { "<cmd>Telescope live_grep<cr>", "Text" },
				["T"] = { "<cmd>Telescope live_grep_args<cr>", "Text with args" },
				["Q"] = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
				["w"] = { "<cmd>Telescope grep_string<cr>", "Word under cursor" },
			},
			["m"] = { "Messages" },
			["S"] = {
				name = "Search & Replace",
				["f"] = {
					"<cmd>lua require('spectre').open_file_search()<CR>",
					"Open file menu",
				},
				["m"] = { "<cmd>lua require('spectre').open()<CR>", "Open menu" },
				["y"] = {
					"<cmd>lua require('spectre').open_visual()<CR>",
					"Replace yank",
				},
				["w"] = {
					"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
					"Replace word under cursor",
				},
			},
			["r"] = {
				name = "Refactoring",
				["b"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
					"Extract block",
				},
				["f"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
					"Extract block to file",
				},
				["e"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
					"Extract function",
				},
				["F"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
					"Extract function to file",
				},
				["i"] = {
					"<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
					"Inline variable",
				},
				["I"] = {
					"<Cmd>lua require('refactoring').refactor('Inline Function')<CR>",
					"Inline function",
				},
				["l"] = {
					"<cmd>lua require('refactoring').debug.printf({below = true})<CR>",
					"Print debug log (below)",
				},
				["L"] = {
					"<cmd>lua require('refactoring').debug.printf({below = false})<CR>",
					"Print debug log (above)",
				},
				["p"] = {
					"<cmd>lua require('refactoring').debug.print_var()<CR>",
					"Print variable",
				},
				["c"] = {
					"<cmd>lua require('refactoring').debug.cleanup({})<CR>",
					"Cleanup debug log",
				},
				["r"] = {
					"<cmd>lua require('refactoring').select_refactor()<CR>",
					"Open selector",
				},
			},
			["R"] = {
				name = "Rest",
				["r"] = { "<Plug>RestNvim", "Run request under the cursor" },
				["p"] = {
					"<Plug>RestNvimPreview",
					"Preview request under the cursor",
				},
				["l"] = { "<Plug>RestNvimLast", "Run last request" },
			},
			["t"] = {
				name = "Test",
				["r"] = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run file tests" },
				["R"] = { '<cmd>lua require("neotest").run.run(vim.loop.cwd())<CR>', "Run all tests" },
				["n"] = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
				["d"] = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', "Debug nearest test" },
				["o"] = {
					'<cmd>lua require("neotest").output.open({ enter = true, auto_close = true })<CR>',
					"Show output",
				},
				["O"] = {
					'<cmd>lua require("neotest").output_panel.toggle()<CR>',
					"Toggle output",
				},
				["s"] = { '<cmd>lua require("neotest").run.stop()<CR>', "Stop test" },
				["t"] = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle summary" },
			},
			["T"] = {
				name = "Toggle",
				["f"] = { "<cmd>FormatToggle<cr>", "Toggle autoformat" },
				["g"] = { "<cmd>Copilot! toggle<cr>", "Toggle GitHub Copilot " },
				["t"] = {
					["h"] = {
						function()
							if vim.b.ts_highlight then
								vim.treesitter.stop()
							else
								vim.treesitter.start()
							end
						end,
						"Toggle highlight",
					},
					"Treesitter",
				},
				["H"] = { "<cmd>ColorizerToggle<cr>", "Toggle highlighted colors" },
				["I"] = {
					"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
					"Toggle inlay hints",
				},
				["z"] = { "<cmd>ZenMode<cr>", "Toggle zenmode" },
			},
			["Q"] = { name = "Session" },
			["x"] = {
				name = "Misc",
				["d"] = { "<cmd>%s/\\s\\+$//e<cr>", "Delete trailing spaces" },
				["p"] = { "<cmd>PeekToggle<cr>", "Toggle preview" },
				["s"] = { "<cmd>ISwap<cr>", "Swap parameters interactively" },
				["u"] = { "<cmd>PP<cr>", "Upload file to dpaste" },
			},
			["z"] = {
				name = "Obsidian",
				["b"] = { "<cmd>ObsidianBacklinks<cr>", "List backlinks" },
				["d"] = { "<cmd>ObsidianDailies -14 1<cr>", "List dailies" },
				["i"] = { "<cmd>ObsidianTemplate<cr>", "Insert template" },
				["l"] = { "<cmd>ObsidianQuickSwitch<cr>", "List notes" },
				["n"] = {
					function()
						local title = vim.fn.input("Title: ")
						if title ~= "" then
							vim.cmd("ObsidianNew " .. title)
						end
					end,
					"Create new note (in current dir)",
				},
				["o"] = { "<cmd>ObsidianOpen<cr>", "Open obsidian" },
				["s"] = { "<cmd>ObsidianSearch<cr>", "Search notes" },
				["t"] = { "<cmd>ObsidianToday<cr>", "Create/open note for today" },
				["T"] = { "<cmd>ObsidianTomorrow<cr>", "Create/open note for tomorrow" },
				["y"] = { "<cmd>ObsidianYesterday<cr>", "Create/open note for yesterday" },
				["w"] = { "<cmd>ObsidianWorkspace<cr>", "Select active workspace" },
			},
		},
	}
	wk.setup(config.setup)
	wk.register(config.mappings, {
		mode = "n",
		prefix = "<leader>",
	})
	wk.register(config.vmappings, {
		mode = "v",
		prefix = "<leader>",
	})
end

return M
