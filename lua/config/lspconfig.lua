local present1, lspconfig = pcall(require, "lspconfig")
local present2, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not (present1 and present2) then
	return
end

local function custom_on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>Lspsaga preview_definition<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>Lspsaga implement<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
	buf_set_keymap("n", "gk", "<cmd>Lspsaga signature_help<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	if client.server_capabilities.colorProvider then
		require("config.tailwind_colors.lsp-documentcolors").buf_attach(bufnr, { single_column = true })
	end
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = cmp_lsp.update_capabilities(custom_capabilities)
custom_capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local prettierd = require("config/efm/prettierd")
local shellcheck = require("config/efm/shellcheck")
local shfmt = require("config/efm/shfmt")

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
			},
		},
		filetypes = {
			"css",
			"fish",
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
	eslint = {
		root_dir = require("lspconfig").util.find_node_modules_ancestor,
	},
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
	html = { init_options = { provideFormatter = false } },
	jsonls = { init_options = { provideFormatter = false } },
	ltex = {
		autostart = false,
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"go",
			"lua",
			"markdown",
			"plaintex",
			"tex",
		},
	},
	prismals = true,
	pyright = true,
	rust_analyzer = true,
	tailwindcss = true,
	stylelint_lsp = {
		autostart = false,
		cmd = {
			"stylelint",
		},
	},
	sumneko_lua = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
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
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		},
	},
	texlab = true,
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
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
		flags = { debounce_text_changes = 150 },
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

local typescript_nvim = require("typescript")

local function disable_lsp_formatting(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false

	client.resolved_capabilities.documentFormattingProvider = false
	client.resolved_capabilities.documentRangeFormattingProvider = false
end

typescript_nvim.setup({
	server = {
		on_attach = function(client, bufnr)
			custom_on_attach(client, bufnr)
			disable_lsp_formatting(client)
		end,
	},
})

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
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
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
