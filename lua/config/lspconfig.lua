local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")
local present3, coq = pcall(require, "coq")

if not (present1 or present2 or present3) then return end

local function on_attach(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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

-- lspInstall + lspconfig stuff

local function setup_servers()
    lspinstall.setup()
    local servers = lspinstall.installed_servers()

    for _, lang in pairs(servers) do
        if lang ~= "lua" then
            lspconfig[lang].setup(coq.lsp_ensure_capabilities({
                capabilities = capabilities,
                flags = {debounce_text_changes = 500}
                -- root_dir = vim.loop.cwd,
            }))
        elseif lang == "lua" then
            lspconfig[lang].setup(coq.lsp_ensure_capabilities({
                capabilities = capabilities,
                flags = {debounce_text_changes = 500},
                settings = {
                    Lua = {
                        diagnostics = {globals = {"vim"}},
                        workspace = {
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000
                        },
                        telemetry = {enable = false}
                    }
                }
            }))
        end
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd "bufdo e"
end

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
    vim.fn.sign_define("LspDiagnosticsSign" .. name,
                       {text = icon, numhl = "LspDiagnosticsDefaul" .. name})
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
vim.notify = function(msg, log_level, _opts)
    if msg:match "exit code" then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end
