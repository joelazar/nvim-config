local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"b0o/SchemaStore.nvim",
		"williamboman/mason.nvim",
		"pmizio/typescript-tools.nvim",
		"dmmulroy/ts-error-translator.nvim",
		{ "folke/neodev.nvim", opts = {} },
	},
}

M.config = function()
	require("mason")
	require("plugins.lsp.diagnostics").setup()

	local lspconfig = require("lspconfig")
	local cmp_lsp = require("cmp_nvim_lsp")

	local function on_attach(client, buffer)
		require("plugins.lsp.keys").setup(buffer)
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
			settings = {
				gopls = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						fieldalignment = true,
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
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
		mojo = {},
		prismals = {},
		pyright = {},
		ruff = {},
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
		zls = {},
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
			elseif server == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
			require("plugins.lsp.keys").setup(buffer)

			-- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			-- 	vim.keymap.set("n", "<leader>TI", function()
			-- 		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			-- 	end, "Toggle inlay hints")
			-- end
		end

		if server == "tsserver" then
			require("typescript-tools").setup({
				on_attach = config.on_attach,
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			})
			require("ts-error-translator").setup()
			vim.lsp.inlay_hint.enable()
		else
			lspconfig[server].setup(config)
		end
	end

	for server, config in pairs(servers) do
		setup_server(server, config)
	end
end

return M
