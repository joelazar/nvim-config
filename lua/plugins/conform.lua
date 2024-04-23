return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo", "FormatToggle", "FormatEnable", "FormatDisable" },
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		format = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_fallback = true,
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 3000, lsp_fallback = true }
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			mojo = { "mojo" },
			-- python = { "isort", "black" },
			["javascript"] = { "prettierd" },
			["javascriptreact"] = { "prettierd" },
			["typescript"] = { "prettierd" },
			["typescriptreact"] = { "prettierd" },
			["vue"] = { "prettierd" },
			["css"] = { "prettierd" },
			["scss"] = { "prettierd" },
			["less"] = { "prettierd" },
			["html"] = { "prettierd" },
			["json"] = { "prettierd" },
			["jsonc"] = { "prettierd" },
			["yaml"] = { "prettierd" },
			["markdown"] = { "prettierd" },
			["markdown.mdx"] = { "prettierd" },
			["graphql"] = { "prettierd" },
			["handlebars"] = { "prettierd" },
			fish = { "fish_indent" },
			sql = { "sqlfluff" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-s", "-ci" },
			},
			sqlfluff = {
				prepend_args = { "--dialect", "postgres" },
			},
			mojo = {
				inherit = false,
				command = "mojo",
				args = { "format", "--quiet", "$FILENAME" },
				stdin = false,
			},
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
				vim.notify("Autoformat disabled for this buffer", "info", { title = "Conform" })
			else
				vim.g.disable_autoformat = true
				vim.notify("Autoformat disabled", "info", { title = "Conform" })
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
			vim.notify("Autoformat enabled", "info", { title = "Conform" })
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		vim.api.nvim_create_user_command("FormatToggle", function()
			if vim.b.disable_autoformat or vim.g.disable_autoformat then
				vim.cmd("FormatEnable")
			else
				vim.cmd("FormatDisable")
			end
		end, {
			desc = "Toggle autoformat-on-save",
		})
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
