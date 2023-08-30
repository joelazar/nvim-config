local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/SchemaStore.nvim",
		"williamboman/mason.nvim",
		{ "pmizio/typescript-tools.nvim", dir = "~/git/vim/plugins/typescript-tools.nvim/" },
		{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
	},
}

M.config = function()
	require("mason")
	require("plugins.lsp.diagnostics").setup()

	local lspconfig = require("lspconfig")
	local cmp_lsp = require("cmp_nvim_lsp")

	local function on_attach(client, buffer)
		require("plugins.lsp.keys").setup(buffer)
		require("plugins.lsp.format").on_attach(client, buffer)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_lsp.default_capabilities(capabilities)
	capabilities.textDocument.colorProvider = {
		dynamicRegistration = true,
	}

	local servers = {
		bashls = {},
		clangd = {},
		cssls = {},
		dockerls = {},
		eslint = {},
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
					codelenses = { generate = true, gc_details = true, test = true, tidy = true },
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
			init_options = { usePlaceholders = true },
			filetypes = { "go", "gomod" },
		},
		html = { init_options = { provideFormatter = false } },
		jsonls = {
			init_options = { provideFormatter = false },
			settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
		},
		lua_ls = {
			settings = {
				Lua = { workspace = { checkThirdParty = false }, completion = { callSnippet = "Replace" } },
			},
		},
		prismals = {},
		pyright = {},
		ruff_lsp = {},
		rust_analyzer = {},
		stylelint_lsp = { autostart = false },
		tailwindcss = { autostart = false },
		taplo = {},
		texlab = {},
		tsserver = {},
		yamlls = {
			-- Have to add this for yamlls to understand that we support line folding
			capabilities = { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } },
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					keyOrdering = false,
					format = { enable = true },
					validate = true,
					schemaStore = {
						--Must disable built-in schemaStore support to use schemas from SchemaStore.nvim plugin
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
				},
			},
		},
	}

	local setup_server = function(server, config)
		config = vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
			flags = { debounce_text_changes = 150 },
		}, config)

		config.on_attach = function(client, buffer)
			if server == "tsserver" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
			require("plugins.lsp.keys").setup(buffer)
			require("plugins.lsp.format").on_attach(client, buffer)
		end

		if server == "tsserver" then
			require("typescript-tools").setup({
				on_attach = config.on_attach,
				separate_diagnostic_server = true,
				expose_as_code_actions = { "fix_all", "add_missing_imports", "remove_unused" },
			})
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
