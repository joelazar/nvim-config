local M = {}
M.config = {
	active = false,
	setup = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
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
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		window = {
			border = "none", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			-- winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			-- align = "center",
		},
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
	secopts = {
		mode = "n", -- NORMAL mode
		prefix = "\\",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	},
	secvopts = {
		mode = "v", -- VISUAL mode
		prefix = "\\",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	},
	-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
	-- see https://neovim.io/doc/user/map.html#:map-cmd
	secmappings = {
		["g"] = { "<cmd>LazyGit<cr>", "Lazygit" },
		["q"] = {
			name = "Quickfix list",
			["l"] = { "<cmd>copen<cr>", "Open quickfix list window" },
			["c"] = { "<cmd>call setqflist([])<cr>", "Clear quickfix list" },
			["n"] = { "<cmd>cnext<cr>", "Select next item in quickfix list" },
			["p"] = { "<cmd>cprev<cr>", "Select previous item in quickfix list" },
		},
	},
	secvmappings = {},
	vmappings = {
		[";"] = {
			'<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
			"Comment Operator",
		},
		["e"] = { "<ESC><CMD>'<,'>SnipRun<cr>", "Execute (sniprun)" },
		["g"] = {
			name = "Git",
			["s"] = {
				'<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
				"Stage Hunk",
			},
			["r"] = {
				'<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
				"Undo Stage Hunk",
			},
			["y"] = {
				'<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
				"Copy link to clipboard",
			},
		},
		["l"] = {
			name = "LSP",
			["A"] = {
				"<cmd>lua vim.lsp.buf.range_code_action()<cr>",
				"Code Action Range",
			},
		},
	},
	mappings = {
		["'"] = {
			"<cmd>1ToggleTerm size=15 direction=horizontal<cr>",
			"Open toggle terminal",
		},
		['"'] = {
			"<cmd>execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>",
			"Open terminal",
		},
		["e"] = { "<cmd>SnipRun<cr>", "Execute (sniprun)" },
		["w"] = { "<cmd>w!<cr>", "Save" },
		["W"] = { "<cmd>:lua require'utils'.sudo_write()<cr>", "Sudo Save" },
		["q"] = { "<cmd>q!<cr>", "Quit" },
		[";"] = { '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment Operator" },
		["n"] = { "<cmd>NnnPicker<cr>", "nnn" },
		["c"] = { "<cmd>Telescope neoclip<cr>", "Clipboard manager" },
		["b"] = {
			name = "Buffers",
			["j"] = { "<cmd>BufferPick<cr>", "Jump to buffer" },
			["d"] = { "<cmd>BufferClose!<cr>", "Delete buffer" },
			["D"] = {
				"<cmd>only<cr><cmd>BufferCloseAllButCurrent<cr>",
				"Close all but current buffer",
			},
			["f"] = {
				-- "<cmd>lua vim.lsp.buf.formatting_seq_sync({}, 2000)<cr>",
				"<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>",
				"Format buffer (LSP)",
			},
			["F"] = { ":Format<cr>", "Format buffer (format.nvim)" },
			["l"] = { "<cmd>BufferMovePrevious<cr>", "Move buffer to the left" },
			["r"] = { "<cmd>BufferMoveNext<cr>", "Move buffer to the right" },
			["L"] = {
				"<cmd>BufferCloseBuffersLeft<cr>",
				"Close all buffers to the left",
			},
			["R"] = {
				"<cmd>BufferCloseBuffersRight<cr>",
				"Close all buffers to the right",
			},
			["p"] = { "<cmd>BufferPrevious<cr>", "Previous buffer" },
			["P"] = { "<cmd>BufferPin<cr>", "Pin/Unpin buffer" },
			["n"] = { "<cmd>BufferNext<cr>", "Next buffer" },
			["s"] = {
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
			["W"] = { "<cmd>BufferCloseAllButPinned<cr>", "Close all but pinned buffer(s)" },
		},
		["d"] = {
			name = "Debug",
			s = {
				name = "Step",
				c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
				v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
				i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
				o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
			},
			h = {
				name = "Hover",
				h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
				v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
			},
			u = {
				name = "UI",
				h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
				f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
			},
			r = {
				name = "Repl",
				o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
				l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
			},
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
			i = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle" },
		},
		["p"] = {
			name = "Packer",
			["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
			["i"] = { "<cmd>PackerInstall<cr>", "Install" },
			["s"] = { "<cmd>PackerSync<cr>", "Sync" },
			["u"] = { "<cmd>PackerUpdate<cr>", "Update" },
		},
		["g"] = {
			name = "Git",
			["j"] = {
				'<cmd>lua require"gitsigns".next_hunk()<cr>',
				"Next Hunk",
			},
			["k"] = {
				'<cmd>lua require"gitsigns".prev_hunk()<cr>',
				"Prev Hunk",
			},
			["l"] = {
				'<cmd>lua require"gitsigns".blame_line{full=true}<cr>',
				"Blame Line",
			},
			["p"] = {
				'<cmd>lua require"gitsigns".preview_hunk()<cr>',
				"Preview Hunk",
			},
			["r"] = {
				'<cmd>lua require"gitsigns".reset_hunk()<cr>',
				"Reset Hunk",
			},
			["R"] = {
				'<cmd>lua require"gitsigns".reset_buffer()<cr>',
				"Reset Buffer",
			},
			["s"] = {
				'<cmd>lua require"gitsigns".stage_hunk()<cr>',
				"Stage Hunk",
			},
			["S"] = {
				'<cmd>lua require"gitsigns".stage_buffer()<cr>',
				"Stage Buffer",
			},
			["u"] = {
				'<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
				"Undo Stage Hunk",
			},
			["D"] = {
				'<cmd>lua require"gitsigns".diffthis()<cr>',
				"Diff this file",
			},
			["o"] = { "<cmd>Telescope git_status<cr>", "Open changed files" },
			["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			["C"] = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			["d"] = {
				name = "Diffview",
				["o"] = { "<cmd>DiffviewOpen<cr>", "Open" },
				["c"] = { "<cmd>DiffviewClose<cr>", "Close" },
				["r"] = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
				["f"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle files" },
			},
			["t"] = {
				name = "Toggle",
				["b"] = { '<cmd>lua require"gitsigns".toggle_current_line_blame()<cr>', "Blame line" },
				["d"] = { '<cmd>lua require"gitsigns".toggle_deleted()<cr>', "Deleted" },
				["h"] = { '<cmd>lua require"gitsigns".toggle_linehl()<cr>', "Line highlight" },
			},
			["y"] = {
				'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
				"Copy link to clipboard",
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
			["a"] = { "<cmd>CodeActionMenu<cr>", "Code Action" },
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
			["h"] = {
				"<cmd>lua vim.lsp.buf.signature_help()<cr>",
				"Signature help",
			},
			["k"] = {
				"<cmd>lua vim.diagnostic.open_float(nil, {source = 'always'})<cr>",
				"Show line diagnostic",
			},
			["i"] = { "<cmd>LspInfo<cr>", "Info" },
			["q"] = {
				"<cmd>lua vim.diagnostic.setqflist()<cr>",
				"Set quickfix list",
			},
			["n"] = {
				"<cmd>lua vim.diagnostic.goto_next()<cr>",
				"Next Diagnostic",
			},
			["p"] = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			["s"] = {
				"<cmd>Telescope lsp_document_symbols<cr>",
				"Document Symbols",
			},
			["S"] = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},
		["m"] = {
			name = "Tasks",
			["g"] = {
				name = "Go",
				["m"] = { "<cmd>AsyncRun make<cr>", "Run default task" },
				["t"] = { "<cmd>AsyncRun make test<cr>", "Run test" },
				["f"] = { "<cmd>GoTestFunc<cr>", "Run test function" },
				["l"] = { "<cmd>AsyncRun make lint<cr>", "Run lint" },
				["d"] = { "<cmd>AsyncRun make docker<cr>", "Run docker" },
				["r"] = { "<cmd>AsyncRun make run-compose<cr>", "Run compose" },
				["u"] = { "<cmd>AsyncRun make deps-u<cr>", "Run update deps" },
			},
		},
		["s"] = {
			name = "Search",
			["b"] = { "<cmd>Telescope buffers<cr>", "Find buffer" },
			["B"] = { "<cmd>Telescope vim_bookmarks all<cr>", "Find bookmarks" },
			["c"] = { "<cmd>Telescope commands<cr>", "Commands" },
			["C"] = {
				"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
				"Colorscheme",
			},
			["f"] = { "<cmd>Telescope find_files<cr>", "Find file" },
			["g"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			["h"] = { "<cmd>Telescope help_tags<cr>", "Find help" },
			["L"] = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
			["k"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			["m"] = { "<cmd>Telescope marks<cr>", "Marks" },
			["M"] = { "<cmd>Telescope man_pages<cr>", "Man pages" },
			["o"] = { "<cmd>Telescope oldfiles<cr>", "Open old files" },
			["r"] = { "<cmd>Telescope resume<cr>", "Open previous search" },
			["R"] = { "<cmd>Telescope registers<cr>", "Registers" },
			["p"] = { "<cmd>TodoTelescope<cr>", "Open TODO comments" },
			["P"] = { "<cmd>Telescope projects<cr>", "Open projects" },
			["t"] = { "<cmd>Telescope live_grep<cr>", "Text" },
			["Q"] = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
			["w"] = { "<cmd>Telescope grep_string<cr>", "Word under cursor" },
		},
		["r"] = {
			name = "Replace",
			["m"] = { "<cmd>lua require('spectre').open()<CR>", "Open menu" },
			["f"] = {
				"<cmd>lua require('spectre').open_file_search()<CR>",
				"Open file menu",
			},
			["w"] = {
				"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				"Replace word under cursor",
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
			["r"] = { "<cmd>Ultest<CR>", "Run tests" },
			["l"] = { "<cmd>UltestLast<CR>", "Run last test" },
			["n"] = { "<cmd>UltestNearest<CR>", "Run nearest test" },
			["s"] = { "<cmd>UltestSummary<CR>", "Toggle summary" },
		},
		["T"] = {
			name = "Treesitter",
			["i"] = { "<cmd>TSConfigInfo<cr>", "Info" },
			["d"] = {
				"<cmd>TSDisableAll rainbow<cr><cmd>TSDisableAll incremental_selection<cr><cmd>TSDisableAll highlight<cr><cmd>TSDisableAll autotag<cr><cmd>TSDisableAll indent<cr>",
				"Disable",
			},
			["e"] = {
				"<cmd>TSEnableAll rainbow<cr><cmd>TSEnableAll incremental_selection<cr><cmd>TSEnableAll highlight<cr><cmd>TSEnableAll autotag<cr><cmd>TSEnableAll indent<cr>",
				"Enable",
			},
		},
		["x"] = {
			name = "Misc",
			["c"] = { "<cmd>ColorizerToggle<cr>", "Toggle colorizer" },
			["C"] = {
				"<cmd>lua vim.opt.list=not vim.opt.list._value<cr>",
				"Toggle hidden characters",
			},
			["d"] = { "<cmd>%s/\\s\\+$//e<cr>", "Delete trailing spaces" },
			["h"] = { ":nohlsearch<cr>", "Remove highlighting of search results" },
			["s"] = { ":ISwap<cr>", "Swap parameters interactively" },
		},
	},
}

M.setup = function()
	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	which_key.setup(M.config.setup)
	which_key.register(M.config.mappings, M.config.opts)
	which_key.register(M.config.vmappings, M.config.vopts)
	which_key.register(M.config.secmappings, M.config.secopts)
	which_key.register(M.config.secvmappings, M.config.secvopts)
end

return M
