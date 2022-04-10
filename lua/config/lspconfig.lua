local present1, lspconfig = pcall(require, "lspconfig")
local present2, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not (present1 and present2) then
	return
end

local function custom_on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	if client.server_capabilities.colorProvider then
		require("config.tailwind_colors.lsp-documentcolors").buf_attach(bufnr, { single_column = true })
	end

	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- if false will avoid organizing imports
			always_organize_imports = true,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",
			inlay_hints_priority = 200, -- priority of the hint extmarks
			inlay_hints_throttle = 150, -- throttle the inlay hint request
			inlay_hints_format = { -- format options for individual hint kind
				Type = {},
				Parameter = {},
				Enum = {},
			},

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = false,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gO", ":TSLspOrganize<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", ":TSLspImportAll<CR>", opts)
	end
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()

custom_capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
custom_capabilities.textDocument.completion.completionItem.preselectSupport = true
custom_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
custom_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
custom_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
custom_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
custom_capabilities.textDocument.completion.completionItem.tagSupport = {
	valueSet = { 1 },
}
custom_capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

custom_capabilities = cmp_lsp.update_capabilities(custom_capabilities)

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local prettierd = require("config/efm/prettierd")
local shellcheck = require("config/efm/shellcheck")
local shfmt = require("config/efm/shfmt")

local function get_lua_runtime()
	local result = {}
	for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
		local lua_path = path .. "/lua/"
		if vim.fn.isdirectory(lua_path) then
			result[lua_path] = true
		end
	end
	return result
end

local servers = {
	bashls = true,
	cssls = true,
	clangd = true,
	dockerls = true,
	efm = {
		init_options = { documentFormatting = true },
		root_dir = vim.loop.cwd,
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				lua = { { formatCommand = "stylua -s --stdin-filepath ${INPUT} -", formatStdin = true } },
				python = {
					{ formatCommand = "black --fast -", formatStdin = true },
					{
						formatCommand = "isort --stdout --profile black -",
						formatStdin = true,
					},
				},
				typescript = { prettierd },
				javascript = { prettierd },
				typescriptreact = { prettierd },
				javascriptreact = { prettierd },
				yaml = { prettierd },
				json = { prettierd },
				html = { prettierd },
				scss = { prettierd },
				css = { prettierd },
				markdown = { prettierd },
				sh = { shellcheck, shfmt },
				sql = {
					{ formatCommand = "pg_format -u 1 -i", formatStdin = true },
				},
				fish = {
					{ formatCommand = "fish_indent" },
				},
				go = {
					{ formatCommand = "goimports" },
				},
			},
		},
		filetypes = {
			"css",
			"fish",
			"go",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"lua",
			"markdown",
			"python",
			"scss",
			"sh",
			"sql",
			"ts",
			"typescript",
			"typescriptreact",
			"yaml",
		},
	},
	eslint = true,
	golangci_lint_ls = true,
	gopls = {
		flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
		settings = {
			gopls = {
				analyses = {
					nilness = true,
					shadow = true,
					unusewrites = true,
					unusedparams = true,
					unreachable = true,
				},
				codelenses = {
					generate = true,
					gc_details = true,
					test = true,
					tidy = true,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				matcher = "Fuzzy",
				diagnosticsDelay = "500ms",
				experimentalWatchedFileDelay = "100ms",
				symbolMatcher = "fuzzy",
				gofumpt = true,
			},
		},
		filetypes = { "go", "gomod" },
	},
	html = true,
	jsonls = { init_options = { provideFormatter = false } },
	ltex = { autostart = false },
	prismals = true,
	pyright = true,
	rust_analyzer = true,
	tailwindcss = true,
	stylelint_lsp = { cmd = {
		"stylelint",
	} },
	sumneko_lua = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				completion = { keywordSnippet = "Disable" },
				diagnostics = {
					enable = true,
					globals = {
						"vim",
						"describe",
						"it",
						"before_each",
						"after_each",
						"teardown",
						"pending",
						"use",
					},
					workspace = {
						library = get_lua_runtime(),
						maxPreload = 1000,
						preloadFileSize = 1000,
					},
				},
			},
		},
	},
	texlab = true,
	tsserver = {
		init_options = require("nvim-lsp-ts-utils").init_options,
	},
	yamlls = true,
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
		flags = { debounce_text_changes = 150 },
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = { prefix = "" },
	signs = true,
	underline = true,
	update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({ { msg } }, true, {})
	end
end
