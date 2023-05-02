local M = {
	"williamboman/mason.nvim",
	cmd = { "Mason" },
}

function M.config()
	require("mason").setup()

	local tools = {
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
		-- "pylint",
		"pyright",
		"ruff-lsp",
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

	local function check()
		local mr = require("mason-registry")
		for _, tool in ipairs(tools) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end

	check()
end

return M
