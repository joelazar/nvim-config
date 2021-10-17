local present1, lspconfig = pcall(require, "lspconfig")
local present2, coq = pcall(require, "coq")

if not (present1 or present2) then return end

local no_lsp_formatting = {["tsserver"] = true}

local function on_attach(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
                   opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                   opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown", "plaintext"
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = {1}
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

local prettier = require "config/efm/prettier"
local shellcheck = require "config/efm/shellcheck"
local shfmt = require "config/efm/shfmt"

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/"
        if vim.fn.isdirectory(lua_path) then result[lua_path] = true end
    end
    result[vim.fn.expand "$VIMRUNTIME/lua"] = true
    result[vim.fn.expand "~/dev/neovim/src/nvim/lua"] = true

    return result
end

local servers = {
    gopls = {
        flags = {allow_incremental_sync = true, debounce_text_changes = 500},
        settings = {
            gopls = {
                analyses = {unusedparams = true, unreachable = true},
                codelenses = {
                    generate = true,
                    gc_details = true,
                    test = true,
                    tidy = true
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                matcher = "Fuzzy",
                diagnosticsDelay = "500ms",
                experimentalWatchedFileDelay = "100ms",
                symbolMatcher = "fuzzy",
                gofumpt = true
            }
        },
        filetypes = {'go', 'gomod'}
    },
    pyright = true,
    tsserver = true,
    eslint = true,
    html = true,
    cssls = true,
    texlab = true,
    bashls = true,
    yamlls = true,
    sumneko_lua = {
        cmd = {"lua-language-server"},
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = {"lua/?.lua", "lua/?/init.lua"}
                },
                completion = {keywordSnippet = "Disable"},
                diagnostics = {
                    enable = true,
                    globals = {
                        "vim", "describe", "it", "before_each", "after_each",
                        "teardown", "pending", "use"
                    },
                    workspace = {
                        library = get_lua_runtime(),
                        maxPreload = 1000,
                        preloadFileSize = 1000
                    }
                }
            }
        }
    },
    jsonls = {init_options = {provideFormatter = false}},
    clangd = true,
    rust_analyzer = true,
    dockerls = true,
    efm = {
        init_options = {documentFormatting = true},
        root_dir = vim.loop.cwd,
        settings = {
            rootMarkers = {".git/"},
            languages = {
                -- go = {
                --     {
                --         lintCommand = "golangci-lint run ./...",
                --         lintStdin = true,
                --         lintIgnoreExitCode = true,
                --         lintFormats = {"%f:%l:%c: %m"},
                --         lintSource = "golangci-lint"
                --     }
                -- },
                lua = {{formatCommand = "lua-format -i", formatStdin = true}},
                python = {
                    {formatCommand = "black --fast -", formatStdin = true},
                    {
                        formatCommand = "isort --stdout --profile black -",
                        formatStdin = true
                    }
                    -- {
                    --     lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
                    --     lintStdin = true,
                    --     lintIgnoreExitCode = true,
                    --     lintFormats = {"%f:%l:%c: %t%n%n%n %m"},
                    --     lintSource = "flake8"
                    -- }
                },
                typescript = {prettier},
                javascript = {prettier},
                typescriptreact = {prettier},
                javascriptreact = {prettier},
                yaml = {prettier},
                json = {prettier},
                html = {prettier},
                scss = {prettier},
                css = {prettier},
                markdown = {prettier},
                sh = {shellcheck, shfmt}
                -- make = {{lintCommand = "checkmake", lintStdin = true}}
            }
        },
        filetypes = {
            'python', 'ts', 'javascript', 'yaml', 'json', 'html', 'css', 'scss',
            'md', 'sh', 'lua' -- 'make'
        }
    }
}

local setup_server = function(server, config)
    if not config then return end

    if type(config) ~= "table" then config = {} end

    local custom_attach = on_attach
    if no_lsp_formatting[server] then
        custom_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
        end
    end

    config = vim.tbl_deep_extend("force", {
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    }, config)

    lspconfig[server].setup(config)
    lspconfig[server].setup(coq.lsp_ensure_capabilities(config))
end

for server, config in pairs(servers) do setup_server(server, config) end

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
    vim.fn.sign_define("LspDiagnosticsSign" .. name,
                       {text = icon, numhl = "LspDiagnosticsDefault" .. name})
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {prefix = "", spacing = 0},
        signs = true,
        underline = true,
        update_in_insert = false -- update diagnostics insert mode
    })
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _)
    if msg:match "exit code" then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
