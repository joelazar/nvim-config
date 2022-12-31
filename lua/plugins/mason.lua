local M = {}

M.setup = function()
	require("mason").setup()

	local ensure_installed = {
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
	vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
	end, {})
end

return M
