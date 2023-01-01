local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/schemastore.nvim",
		"williamboman/mason.nvim",
		"glepnir/lspsaga.nvim",
		"jose-elias-alvarez/typescript.nvim",
	},
}

M.config = function()
	require("mason")
	require("plugins.lsp.diagnostics").setup()

	require("lspsaga").init_lsp_saga({
		code_action_lightbulb = {
			virtual_text = false,
			enable_in_insert = false,
		},
		symbol_in_winbar = {
			enable = false,
		},
		show_outline = {
			jump_key = "<CR>",
		},
		max_preview_lines = 50,
	})

	local lspconfig = require("lspconfig")
	local cmp_lsp = require("cmp_nvim_lsp")

	local function on_attach(_, buffer)
		require("plugins.lsp.keys").setup(buffer)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_lsp.default_capabilities(capabilities)
	capabilities.textDocument.colorProvider = {
		dynamicRegistration = true,
	}

	local servers = {
		bashls = {},
		cssls = {},
		clangd = {},
		dockerls = {},
		golangci_lint_ls = {},
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
					experimentalPostfixCompletions = true,
					symbolMatcher = "fuzzy",
					gofumpt = true,
				},
			},
			init_options = {
				usePlaceholders = true,
			},
			filetypes = { "go", "gomod" },
		},
		html = { init_options = { provideFormatter = false } },
		jsonls = {
			init_options = { provideFormatter = false },
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		},
		prismals = {},
		pyright = {},
		rust_analyzer = {},
		tailwindcss = {},
		stylelint_lsp = {
			autostart = false,
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
		texlab = {},
		tsserver = {},
		yamlls = {},
	}

	local setup_server = function(server, config)
		config = vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
			flags = { debounce_text_changes = 150 },
		}, config)

		if server == "tsserver" then
			local function disable_lsp_formatting(client)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			config.on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				disable_lsp_formatting(client)
			end

			require("typescript").setup({ server = config })
		else
			lspconfig[server].setup(config)
		end
	end

	for server, config in pairs(servers) do
		setup_server(server, config)
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
	vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

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
end

return M
