local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

M.config = function()
	local wk = require("which-key")

	local config = {
		setup = {
			preset = "helix", -- "classic" | "modern" | "helix"
			delay = 200,
			layout = { align = "center" }, -- align columns left, center or right
			sort = { "order", "group", "alphanum", "mod", "lower", "icase" },
			icons = {
				rules = false,
				group = "",
			},
		},
		mappings = {
			{
				mode = { "n" },
				{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },

				{
					"<leader>bF",
					function()
						vim.lsp.buf.format({ async = true })
					end,
					desc = "Format buffer (LSP)",
				},
				{ "<leader>bL", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all buffers to the left" },
				{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Pin/Unpin buffer" },
				{ "<leader>bR", "<cmd>BufferLineCloseRight<cr>", desc = "Close all buffers to the right" },
				{ "<leader>bs", "<cmd>Telescope buffers<cr>", desc = "Search buffers" },
				{ "<leader>bw", "<cmd>BufferLineCloseOthers<cr>", desc = "Close all but current buffer" },
				{ "<leader>bW", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Close all but pinned buffers" },
				{ "<leader>bS", group = "Sort buffers" },
				{
					"<leader>bSd",
					"<cmd>BufferLineSortByDirectory<cr>",
					desc = "Sort buffers automatically by directory",
				},
				{
					"<leader>bSl",
					"<cmd>BufferLineSortByExtension<cr>",
					desc = "Sort buffers automatically by language",
				},

				{ "<leader>C", "<cmd>Telescope neoclip<cr>", desc = "Clipboard manager" },
				{ "<leader>f", "<cmd>NnnExplorer<cr>", desc = "nnn" },
				{ "<leader>F", "<cmd>NnnExplorer %:p:h<cr>", desc = "nnn (current dir)" },
				{ "<leader>n", "<cmd>NnnPicker<cr>", desc = "nnn" },
				{ "<leader>N", "<cmd>NnnPicker %:p:h<cr>", desc = "nnn  (current dir)" },
				{ "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undotree" },
				{
					"<leader>Sw",
					'<cmd>lua require("spectre").open_visual({ select_word = true })<cr>',
					desc = "Replace word under cursor",
				},
				{ "<leader>T", group = "Toggle" },
				{ "<leader>Tt", group = "Treesitter" },
				{ "<leader>Tf", "<cmd>FormatToggle<cr>", desc = "Toggle autoformat" },
				{ "<leader>Tg", "<cmd>Copilot! toggle<cr>", desc = "Toggle copilot" },
				{ "<leader>TH", "<cmd>ColorizerToggle<cr>", desc = "Toggle highlight colors" },
				{
					"<leader>TI",
					function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end,
					desc = "Toggle inlay hints",
				},
				{ "<leader>Tz", "<cmd>ZenMode<cr>", desc = "Toggle zenmode" },
				{
					"<leader>Tth",
					function()
						if vim.b.ts_highlight then
							vim.treesitter.stop()
						else
							vim.treesitter.start()
						end
					end,
					desc = "Toggle highlight",
				},

				{ "<leader>m", group = "Messages" },
				{ "<leader>Q", group = "Session" },

				{ "<leader>zl", "<cmd>ObsidianQuickSwitch<cr>", desc = "List notes" },
				{
					"<leader>zn",
					function()
						local title = vim.fn.input("Title: ")
						if title ~= "" then
							vim.cmd("ObsidianNew " .. title)
						end
					end,
					desc = "Create new note (in current dir)",
				},
			},
			{
				mode = { "v" },
				{
					"<leader>gy",
					'<cmd>lua require("gitlinker").get_buf_range_url( "v", { action_callback = "<cmd>lua require("gitlinker.actions").copy_to_clipboard })<cr>',
					desc = "Copy link to clipboard",
				},
				{ "<leader>e", ":SnipRun<cr>", desc = "Execute (sniprun)" },
				{
					"<leader>Sw",
					"<esc><cmd>lua require('spectre').open_visual()<cr>",
					desc = "Visual selection",
				},
				{ "<leader>zl", "<cmd>ObsidianLink<CR>", desc = "Link a note" },
				{
					"<leader>zn",
					function()
						local title = vim.fn.input("Title: ")
						if title ~= "" then
							vim.cmd("ObsidianLinkNew " .. title)
						end
					end,
					desc = "Create new linked note (in current dir)",
				},
			},
			{
				mode = { "n", "v" },

				{ "<leader>a", group = "AI" },
				{ "<leader>aa", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT - Act as" },
				{
					"<leader>ae",
					"<cmd>ChatGPTEditWithInstruction<CR>",
					desc = "ChatGPT - Edit with instruction",
				},
				{ "<leader>as", "<cmd>ChatGPT<CR>", desc = "ChatGPT - Session" },
				{ "<leader>at", "<cmd>Telescope gpt<CR>", desc = "ChatGPT - Custom actions" },

				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Copilot" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "LSP" },

				{ "<leader>s", group = "Search" },
				{ "<leader>S", group = "Search & Replace" },
				{ "<leader>z", group = "Obsidian" },

				{ "<leader>q", "<cmd>q!<cr>", desc = "Quit" },
				{ "<leader>w", "<cmd>w!<cr>", desc = "Write" },
				{ "<leader>W", '<cmd>lua require("config.utils").sudo_write()', desc = "Write (sudo)" },

				{ "[", group = "Backward/First" },
				{ "]", group = "Forward/Last" },
				{ "g", group = "Goto" },
				{ "gs", group = "Surround" },
				{ "z", group = "Fold" },

				{ "<leader>d", group = "Debug" },
				{ "<leader>db", name = "Breakpoints" },
				{
					"<leader>dbc",
					'<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>',
					desc = "Breakpoint condition",
				},
				{
					"<leader>dbm",
					'<cmd>lua require("dap").set_breakpoint({ nil, nil, vim.fn.input("Log point message: ") })<cr>',
					desc = "Log point message",
				},
				{ "<leader>dbt", '<cmd>lua require("dap").toggle_breakpoint()<cr>', desc = "Create" },

				{ "<leader>dh", group = "Hover" },
				{ "<leader>dhh", '<cmd>lua require("dap.ui.variables").hover()<cr>', desc = "Hover" },
				{ "<leader>dhv", '<cmd>lua require("dap.ui.variables").visual_hover()<cr>', desc = "Visual hover" },
				{ "<leader>dr", group = "Run" },
				{ "<leader>dro", '<cmd>lua require("dap").repl.toggle()<cr>', desc = "Toggle" },
				{ "<leader>drl", '<cmd>lua require("dap").repl.run_last()<cr>', desc = "Run last" },
				{ "<leader>dR", '<cmd>lua require("dap").run_to_cursor()<cr>', desc = "Run to cursor" },
				{ "<leader>ds", group = "Step" },
				{ "<leader>dsc", '<cmd>lua require("dap").continue()<cr>', desc = "Continue" },
				{ "<leader>dsv", '<cmd>lua require("dap").step_over()<cr>', desc = "Step over" },
				{ "<leader>dsi", '<cmd>lua require("dap").step_into()<cr>', desc = "Step into" },
				{ "<leader>dso", '<cmd>lua require("dap").step_out()<cr>', desc = "Step out" },
				{ "<leader>dt", '<cmd>lua require("dapui").toggle()<cr>', desc = "Toggle" },
				{ "<leader>du", group = "Widget" },
				{ "<leader>duh", '<cmd>lua require("dap.ui.widgets").hover()<cr>', desc = "Hover" },
				{
					"<leader>duf",
					"local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>",
					desc = "Float",
				},

				{ "<leader>D", group = "Devdocs" },
				{ "<leader>Do", "<cmd>DevdocsOpen<cr>", desc = "Open docs" },
				{ "<leader>Dc", "<cmd>DevdocsOpenCurrent<cr>", desc = "Open docs for current filetype" },

				{ "<leader>P", group = "Plugin manager" },
				{ "<leader>Pm", "<cmd>Lazy<cr>", desc = "Lazy menu" },
				{ "<leader>Pr", "<cmd>Lazy restore<cr>", desc = "Lazy restore" },
				{ "<leader>Ps", "<cmd>Lazy sync<cr>", desc = "Lazy sync" },
				{ "<leader>Pu", "<cmd>Lazy update<cr>", desc = "Lazy update" },

				{ "<leader>gt", group = "Telescope" },
				{ "<leader>gtb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
				{ "<leader>gtc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
				{ "<leader>gtf", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit (for current file)" },
				{ "<leader>gts", "<cmd>Telescope git_status<cr>", desc = "Status" },
				{ "<leader>gtS", "<cmd>Telescope git_stash<cr>", desc = "Stash" },
				{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open" },
				{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close" },
				{ "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "History" },
				{ "<leader>gdH", "<cmd>DiffviewFileHistory %<cr>", desc = "History for current file only" },
				{ "<leader>gdr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh stats and entries" },
				{ "<leader>gdf", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle files panel" },
				{
					"<leader>gy",
					'<cmd>lua "<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = "<cmd>lua require"gitlinker.actions".copy_to_clipboard})<cr>',
					desc = "Copy link to clipboard",
				},
				{
					"<leader>gq",
					"<cmd>Gitsigns setqflist<cr>",
					desc = "Trouble list with hunks",
				},

				{
					"<leader>la",
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "Code action",
				},
				{ "<leader>lc", group = "Codelens" },
				{
					"<leader>lcr",
					function()
						vim.lsp.codelens.run()
					end,
					desc = "Run",
				},
				{
					"<leader>lcd",
					function()
						vim.lsp.codelens.display()
					end,
					desc = "Display",
				},
				{
					"<leader>lcu",
					function()
						vim.lsp.codelens.refresh()
					end,
					desc = "Update",
				},
				{
					"<leader>ld",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Workspace diagnostics (Trouble)",
				},
				{
					"<leader>lD",
					"<cmd>Telescope diagnostics<cr>",
					desc = "Workspace diagnostics (telescope)",
				},
				{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
				{
					"<leader>lk",
					function()
						vim.lsp.buf.hover()
					end,
					desc = "Toggle hover doc",
				},
				{
					"<leader>ll",
					function()
						vim.diagnostic.open_float()
					end,
					desc = "Show line diagnostics",
				},
				{
					"<leader>lr",
					function()
						vim.lsp.buf.rename()
					end,
					desc = "Rename",
				},
				{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
				{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
				{
					"<leader>lt",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Document symbols (Trouble)",
				},

				{ "<leader>o", group = "Overseer" },

				{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
				{ "<leader>sb", "<cmd>Telescope vim_bookmarks all<cr>", desc = "Bookmarks" },
				{ "<leader>sB", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
				{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
				{ "<leader>sC", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme" },
				{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Files" },
				{ "<leader>sh", "<cmd>Telescope command_history<cr>", desc = "Command history" },
				{ "<leader>sH", "<cmd>Telescope help_tags<cr>", desc = "Help" },
				{ "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jump list" },
				{ "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location list" },
				{ "<leader>sL", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
				{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
				{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
				{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man pages" },
				{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened files" },
				{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Recent search" },
				{ "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
				{ "<leader>sp", "<cmd>TodoTelescope<cr>", desc = "TODO comments" },
				{ "<leader>sP", "<cmd>Telescope projects<cr>", desc = "Projects" },
				{ "<leader>ss", "<cmd>Telescope smart_open<cr>", desc = "Smart open" },
				{ "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
				{ "<leader>sT", "<cmd>Telescope live_grep_args<cr>", desc = "Text with args" },
				{ "<leader>sQ", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
				{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },

				{
					"<leader>Sf",
					'<cmd>lua require("spectre").open_file_search()<cr>',
					desc = "Open file menu",
				},
				{
					"<leader>Sm",
					'<cmd>lua require("spectre").open()<cr>',
					desc = "Open menu",
				},
				{
					"<leader>Sy",
					'<cmd>lua require("spectre").open_visual()<cr>',
					desc = "Replace yank",
				},
				{ "<leader>R", group = "Rest" },
				{ "<leader>Rr", "<Plug>RestNvim", desc = "Run request under the cursor" },
				{ "<leader>Rp", "<Plug>RestNvimPreview", desc = "Preview request under the cursor" },
				{ "<leader>Rl", "<Plug>RestNvimLast", desc = "Run last request" },

				{ "<leader>t", group = "Test" },
				{
					"<leader>tr",
					'<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>',
					desc = "Run file tests",
				},
				{ "<leader>tR", '<cmd>lua require("neotest").run.run(vim.loop.cwd())<cr>', desc = "Run all tests" },
				{ "<leader>tn", '<cmd>lua require("neotest").run.run()<cr>', desc = "Run nearest test" },
				{
					"<leader>td",
					'<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>',
					desc = "Debug nearest test",
				},
				{
					"<leader>to",
					'<cmd>lua require("neotest").output.open({ enter = true, auto_close = true })<cr>',
					desc = "Show output",
				},
				{ "<leader>tO", '<cmd>lua require("neotest").output_panel.toggle()<cr>', desc = "Toggle output" },
				{ "<leader>ts", '<cmd>lua require("neotest").run.stop()<cr>', desc = "Stop test" },
				{ "<leader>tt", '<cmd>lua require("neotest").summary.toggle()<cr>', desc = "Toggle summary" },

				{ "<leader>x", group = "Misc" },
				{
					"<leader>xd",
					"<cmd>%s/\\s\\+$//e<cr>",
					desc = "Delete trailing spaces",
				},
				{ "<leader>xp", "<cmd>PeekToggle<cr>", desc = "Toggle preview" },
				{
					"<leader>xs",
					"<cmd>ISwap<cr>",
					desc = "Swap parameters interactively",
				},
				{
					"<leader>xu",
					"<cmd>PP<cr>",
					desc = "Upload file to dpaste",
				},

				{ "<leader>zb", "<cmd>ObsidianBacklinks<cr>", desc = "List backlinks" },
				{ "<leader>zd", "<cmd>ObsidianDailies -14 1<cr>", desc = "List dailies" },
				{ "<leader>zi", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
				{ "<leader>zo", "<cmd>ObsidianOpen<cr>", desc = "Open obsidian" },
				{ "<leader>zs", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
				{ "<leader>zt", "<cmd>ObsidianToday<cr>", desc = "Create/open note for today" },
				{ "<leader>zT", "<cmd>ObsidianTomorrow<cr>", desc = "Create/open note for tomorrow" },
				{ "<leader>zy", "<cmd>ObsidianYesterday<cr>", desc = "Create/open note for yesterday" },
				{ "<leader>zw", "<cmd>ObsidianWorkspace<cr>", desc = "Select active workspace" },
			},
		},
	}
	wk.setup(config.setup)
	wk.add(config.mappings)
end

return M
