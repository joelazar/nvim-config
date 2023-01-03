local M = {
	"williamboman/mason.nvim",
	cmd = { "Mason" },
}

M.tools = {
	"actionlint",
	"bash-language-server",
	"black",
	"chrome-debug-adapter",
	"clangd",
	"css-lsp",
	"delve",
	"dockerfile-language-server",
	"eslint-lsp",
	"eslint_d",
	"firefox-debug-adapter",
	"flake8",
	"gofumpt",
	"golangci-lint-langserver",
	"gopls",
	"gotestsum",
	"html-lsp",
	"isort",
	"js-debug-adapter",
	"json-lsp",
	"lua-language-server",
	"mypy",
	"node-debug2-adapter",
	"prettierd",
	"prisma-language-server",
	"pylint",
	"pyright",
	"rust-analyzer",
	"shellcheck",
	"shfmt",
	"sqlfluff",
	"stylelint-lsp",
	"stylua",
	"tailwindcss-language-server",
	"texlab",
	"typescript-language-server",
	"yaml-language-server",
}

function M.check()
	local mr = require("mason-registry")
	for _, tool in ipairs(M.tools) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end

function M.config()
	require("mason").setup()
	M.check()
end

return M
