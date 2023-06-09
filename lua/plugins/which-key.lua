local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

M.config = function()
	local wk = require("which-key")

	local config = {
		setup = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
				spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
			},
			operators = { gc = "Comments" },
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "", -- symbol prepended to a group
			},
			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "center",
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = {
				"<silent>",
				"<cmd>",
				"<Cmd>",
				"<cr>",
				"call",
				"lua",
				"^:",
				"^ ",
			}, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			show_keys = true,
			triggers = "auto", -- automatically setup triggers
			triggers_nowait = {
				-- marks
				"`",
				"'",
				"g`",
				"g'",
				-- registers
				'"',
				"<c-r>",
				-- spelling
				"z=",
			},
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
			-- disable the WhichKey popup for certain buf types and file types.
			-- Disabled by default for Telescope
			disable = {
				buftypes = {},
				filetypes = {},
			},
		},
		opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
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
					"<cmd>Lspsaga code_action<cr>",
					"Code Action",
				},
			},
			["e"] = { ":SnipRun<cr>", "Execute (sniprun)" },
			["r"] = {
				name = "Refactoring",
				["e"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>",
					"Extract Function",
				},
				["f"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
					"Extract Function to File",
				},
				["v"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
					"Extract Variable",
				},
				["i"] = {
					"<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
					"Inline Variable",
				},
				["r"] = {
					"<cmd>lua require('refactoring').select_refactor()<CR>",
					"Select refactor",
				},
				["p"] = {
					"<cmd>lua require('refactoring').debug.print_var({})<CR>",
					"Print variable",
				},
			},
			["s"] = {
				name = "Search",
				["w"] = { '<cmd>lua require"plugins.telescope".grep_string_visual()<CR>', "Visual selection" },
			},
		},
		mappings = {
			["'"] = {
				"<cmd>ToggleTerm size=20 direction=horizontal<cr>",
				"Open toggle terminal",
			},
			['"'] = {
				"<cmd>execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>",
				"Open terminal",
			},
			["c"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },
			["C"] = { "<cmd>Telescope neoclip<cr>", "Clipboard manager" },
			["f"] = { "<cmd>Telescope file_browser<cr>", "File browser" },
			["G"] = { "<cmd>lua require'config.utils'.open_lazygit()<cr>", "Lazygit" },
			["n"] = { "<cmd>NnnPicker<cr>", "nnn" },
			["N"] = { "<cmd>NnnPicker %:p:h<cr>", "nnn (current buffer dir)" },
			["q"] = { "<cmd>q!<cr>", "Quit" },
			["u"] = { "<cmd>Telescope undo<cr>", "Undotree" },
			["w"] = { "<cmd>w!<cr>", "Save" },
			["W"] = { "<cmd>lua require'config.utils'.sudo_write()<cr>", "Sudo Save" },
			["b"] = {
				name = "Buffers",
				["d"] = { "<cmd>BufferClose<cr>", "Delete buffer" },
				["D"] = { "<cmd>BufferClose!<cr>", "Force Delete buffer" },
				["f"] = {
					"<cmd>lua vim.lsp.buf.format({ async = true })<cr>",
					"Format buffer (LSP)",
				},
				["L"] = {
					"<cmd>BufferCloseBuffersLeft<cr>",
					"Close all buffers to the left",
				},
				["P"] = { "<cmd>BufferPin<cr>", "Pin/Unpin buffer" },
				["R"] = {
					"<cmd>BufferCloseBuffersRight<cr>",
					"Close all buffers to the right",
				},
				["s"] = { "<cmd>Telescope buffers<cr>", "Search buffers" },
				["S"] = {
					name = "Sort buffers",
					["d"] = {
						"<cmd>BufferOrderByDirectory<cr>",
						"Sort buffers automatically by directory",
					},
					["l"] = {
						"<cmd>BufferOrderByLanguage<cr>",
						"Sort buffers automatically by language",
					},
				},
				["w"] = {
					"<cmd>only<cr><cmd>BufferCloseAllButCurrent<cr>",
					"Close all but current buffer",
				},
				["W"] = { "<cmd>BufferCloseAllButPinned<cr>", "Close all but pinned buffers" },
			},
			["d"] = {
				name = "Debug",
				b = {
					name = "Breakpoints",
					c = {
						"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
						"Breakpoint Condition",
					},
					m = {
						"<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
						"Log Point Message",
					},
					t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
				},
				h = {
					name = "Hover",
					h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
					v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
				},
				r = {
					name = "Repl",
					o = { "<cmd>lua require('dap').repl.toggle()<CR>", "Toggle" },
					l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
				},
				R = {
					"<cmd>lua require('dap').run_to_cursor()<CR>",
					"Run to cursor",
				},
				s = {
					name = "Step",
					c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
					v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
					i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
					o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
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
			["L"] = {
				name = "Lazy",
				["m"] = { "<cmd>Lazy<cr>", "Menu" },
				["u"] = { "<cmd>Lazy update<cr>", "Update" },
				["s"] = { "<cmd>Lazy sync<cr>", "Sync" },
			},
			["g"] = {
				name = "Git",
				["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				["C"] = {
					"<cmd>Telescope git_bcommits<cr>",
					"Checkout commit (for current file)",
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
				["o"] = { "<cmd>Telescope git_status<cr>", "Open changed files" },
				["y"] = {
					'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
					"Copy link to clipboard",
				},
				["q"] = {
					"<cmd>Gitsigns setqflist<cr>",
					"Open quickfix list with hunks",
				},
			},
			["h"] = {
				name = "Hop",
				["c"] = { "<cmd>HopChar1<cr>", "Hop to single char" },
				["C"] = { "<cmd>HopChar2<cr>", "Hop to bigram" },
				["l"] = { "<cmd>HopLine<cr>", "Hop to line" },
				["L"] = { "<cmd>HopLineStart<cr>", "Hop to line start" },
				["p"] = { "<cmd>HopPattern<cr>", "Hop to pattern" },
				["w"] = { "<cmd>HopWord<cr>", "Hop to word" },
			},
			["l"] = {
				name = "LSP",
				["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
				["c"] = {
					name = "Codelens",
					["r"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run" },
					["d"] = { "<cmd>lua vim.lsp.codelens.display()<cr>", "Display" },
					["u"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Update" },
				},
				["d"] = { "<cmd>Trouble<cr>", "Workspace Diagnostics (Trouble)" },
				["D"] = {
					"<cmd>Telescope diagnostics<cr>",
					"Workspace Diagnostics (Telescope)",
				},
				["i"] = { "<cmd>LspInfo<cr>", "Info" },
				["k"] = {
					"<cmd>Lspsaga hover_doc ++keep<cr>",
					"Toggle hover doc",
				},
				["l"] = {
					"<cmd>Lspsaga show_line_diagnostics<cr>",
					"Show line diagnostics",
				},
				["q"] = {
					"<cmd>lua vim.diagnostic.setqflist()<cr>",
					"Set quickfix list",
				},
				["r"] = { "<cmd>Lspsaga rename<cr>", "Rename" },
				["o"] = {
					"<cmd>Lspsaga outline<cr>",
					"Toggle Outline",
				},
				["s"] = {
					"<cmd>Telescope lsp_document_symbols<cr>",
					"Document Symbols",
				},
				["S"] = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace Symbols",
				},
			},
			["o"] = {
				name = "Overseer",
				["l"] = { "<cmd>OverseerRun<cr>", "List tasks in project" },
				["r"] = { "<cmd>OverseerRestartLast<cr>", "Restart last task" },
				["t"] = { "<cmd>OverseerToggle<cr>", "Toggle summary window" },
			},
			["s"] = {
				name = "Search",
				["b"] = { "<cmd>Telescope vim_bookmarks all<cr>", "Bookmarks" },
				["B"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
				["c"] = { "<cmd>Telescope commands<cr>", "Commands" },
				["C"] = {
					"<cmd>Telescope colorscheme enable_preview=true<cr>",
					"Colorscheme",
				},
				["f"] = { "<cmd>Telescope find_files<cr>", "Files" },
				["h"] = { "<cmd>Telescope command_history<cr>", "Command history" },
				["H"] = { "<cmd>Telescope help_tags<cr>", "Help" },
				["L"] = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
				["k"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				["m"] = { "<cmd>Telescope marks<cr>", "Marks" },
				["M"] = { "<cmd>Telescope man_pages<cr>", "Man pages" },
				["o"] = { "<cmd>Telescope oldfiles<cr>", "Old files" },
				["r"] = { "<cmd>Telescope resume<cr>", "Recent search" },
				["R"] = { "<cmd>Telescope registers<cr>", "Registers" },
				["p"] = { "<cmd>TodoTelescope<cr>", "TODO comments" },
				["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
				["t"] = { "<cmd>Telescope live_grep<cr>", "Text" },
				["T"] = { "<cmd>Telescope live_grep_args<cr>", "Text with args" },
				["Q"] = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
				["w"] = { "<cmd>Telescope grep_string<cr>", "Word under cursor" },
			},
			["S"] = {
				name = "Search and replace",
				["f"] = {
					"<cmd>lua require('spectre').open_file_search()<CR>",
					"Open file menu",
				},
				["m"] = { "<cmd>lua require('spectre').open()<CR>", "Open menu" },
				["w"] = {
					"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
					"Replace word under cursor",
				},
			},
			["r"] = {
				name = "Rest",
				["r"] = { "<Plug>RestNvim", "Run request under the cursor" },
				["p"] = {
					"<Plug>RestNvimPreview",
					"Preview request under the cursor",
				},
				["l"] = { "<Plug>RestNvimLast", "Run last request" },
			},
			["R"] = {
				name = "Refactoring",
				["b"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
					"Extract Block",
				},
				["f"] = {
					"<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
					"Extract Block to File",
				},
				["i"] = {
					"<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
					"Inline Variable",
				},
				["l"] = {
					"<cmd>lua require('refactoring').debug.printf({below = true})<CR>",
					"Print debug log",
				},
				["p"] = {
					"<cmd>lua require('refactoring').debug.print_var({ normal = true })<CR>",
					"Print variable",
				},
				["c"] = {
					"<cmd>lua require('refactoring').debug.cleanup({})<CR>",
					"Cleanup debug log",
				},
			},
			["t"] = {
				name = "Test",
				["r"] = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run tests" },
				["n"] = { '<cmd>lua require("neotest").run.run()<CR>', "Run nearest test" },
				["d"] = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', "Debug nearest test" },
				["s"] = { '<cmd>lua require("neotest").run.stop()<CR>', "Stop test" },
				["t"] = { '<cmd>lua require("neotest").summary.toggle()<CR>', "Toggle summary" },
			},
			["T"] = { name = "Toggle" },
			["x"] = {
				name = "Misc",
				["c"] = { "<cmd>ColorizerToggle<cr>", "Toggle colorizer" },
				["d"] = { "<cmd>%s/\\s\\+$//e<cr>", "Delete trailing spaces" },
				["g"] = {
					name = "GitHub Copilot",
					["d"] = {
						"<cmd>let b:copilot_enabled=0<cr>",
						"Force disable",
					},
					["e"] = {
						"<cmd>let b:copilot_enabled=1<cr>",
						"Force enable",
					},
				},
				["m"] = {
					name = "Markdown preview",
					["c"] = {
						"<cmd>PeekClose<cr>",
						"Close preview",
					},
					["o"] = {
						"<cmd>PeekOpen<cr>",
						"Open preview",
					},
				},
				["s"] = { "<cmd>ISwap<cr>", "Swap parameters interactively" },
				["u"] = { "<cmd>PP<cr>", "Upload file to dpaste" },
				["z"] = { "<cmd>ZenMode<cr>", "ZenMode" },
			},
			["z"] = {
				name = "Notes",
				["n"] = { "<cmd>ZkNew<cr>", "Create new note" },
				["l"] = {
					"<cmd>ZkNotes<cr>",
					"List all notes",
				},
				["r"] = {
					'<cmd>ZkNotes { modifiedAfter = "5 days ago"}<cr>',
					"Recent notes",
				},
				["w"] = {
					'<cmd>ZkNotes { tags = { "work" }}<cr>',
					"List work notes",
				},
				["W"] = { '<cmd>ZkNew { dir = "work" }<cr>', "Create new work note" },
			},
		},
	}
	wk.setup(config.setup)
	wk.register(config.mappings, config.opts)
	wk.register(config.vmappings, config.vopts)
end

return M
