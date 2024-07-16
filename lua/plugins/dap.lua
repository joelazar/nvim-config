local M = {
	"mfussenegger/nvim-dap",
	ft = {
		"go",
		"javascript",
		"javascriptreact",
		"mojo",
		"python",
		"typescript",
		"typescriptreact",
	},
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
			opts = true,
		},
		{ "theHamsta/nvim-dap-virtual-text", opts = true },
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
		{ "LiadOz/nvim-dap-repl-highlights", opts = true },
	},
	-- stylua: ignore
	keys = {
		{ "<F5>",  function() require("dap").continue() end,  desc = "DAP: Continue",  mode = "n" },
		{ "<F10>", function() require("dap").step_over() end, desc = "DAP: Step Over", mode = "n" },
		{ "<F11>", function() require("dap").step_into() end, desc = "DAP: Step Into", mode = "n" },
		{ "<F12>", function() require("dap").step_out() end,  desc = "DAP: Step Out",  mode = "n" },
	},
}

M.config = function()
	local dap = require("dap")
	local dapui = require("dapui")

	vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define(
		"DapStopped",
		{ text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
	)
	vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "", linehl = "", numhl = "" })

	-- dap.set_log_level("TRACE")

	-- Automatically open UI
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	-- Keybindings
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<F5>", "<CMD>lua require('dap').continue()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<S-F5>", "<CMD>lua require('dap').terminate()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<F9>", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<F10>", "<CMD>lua require('dap').step_over()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<F11>", "<CMD>lua require('dap').step_into()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<S-F11>", "<CMD>lua require('dap').step_out()<CR>", opts)

	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
	}

	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
	}

	dap.adapters.chrome = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
	}

	-- TODO: not working
	-- dap.adapters["pwa-node"] = {
	-- 	type = "server",
	-- 	host = "127.0.0.1",
	-- 	port = "9229",
	-- 	executable = {
	-- 		command = "js-debug-adapter",
	-- 		args = { "9229" },
	-- 	},
	-- }

	dap.configurations.typescript = {
		-- Working configs 🎉
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Node - Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
		{
			name = "Firefox - Launch localhost",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:3000",
			-- TODO - webRoot should be set directly to workspaceFolder
			webRoot = "${workspaceFolder}/src",
			firefoxExecutable = "/usr/bin/firefox",
		},
		{
			name = "Chrome - Launch localhost",
			type = "chrome",
			request = "launch",
			runtimeExecutable = "/usr/bin/chromium",
			-- TODO - webRoot should be set directly to workspaceFolder
			webRoot = "${workspaceFolder}/src/build",
			url = "http://localhost:3000",
		},

		-- Not tested configs yet 🙀
		{
			name = "Nope - Node launch file",
			type = "node2",
			request = "launch",
			runtimeExecutable = "npm",
			runtimeArgs = { "run", "dev" },
			args = { "${file}" },
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			name = "Nope - Debug with Chrome",
			type = "chrome",
			request = "attach",
			sourceMaps = true,
			program = "${file}",
			port = 9222,
			webRoot = "${workspaceFolder}/src",
		},
		{
			name = "Nope - Run npm run dev",
			command = "npm run dev",
			request = "launch",
			type = "node-terminal",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Nope - Node - Launch with pwa-node",
			program = "${file}",
			cwd = "${workspaceFolder}",
			port = 9229,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Nope - Node - Attach with pwa-node",
			processId = require("dap.utils").pick_process,
			-- cwd = "${workspaceFolder}/src",
			-- port = 9229,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Nope - Node - Debug Jest Tests with pwa-node",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}

	dap.configurations.typescriptreact = dap.configurations.typescript
	dap.configurations.javascript = dap.configurations.typescript
	dap.configurations.javascriptreact = dap.configurations.typescript

	dap.adapters.delve = {
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
	}

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
		{
			type = "delve",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		-- works with go.mod packages and sub packages
		{
			type = "delve",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}

	local path = require("mason-registry").get_package("debugpy"):get_install_path()
	require("dap-python").setup(path .. "/venv/bin/python")
	require("dap-go").setup()

	-- TODO: mojo debugging is not working yet
	-- dap.adapters.lldb = {
	-- 	type = "executable",
	-- 	command = "lldb-vscode",
	-- 	name = "lldb",
	-- }

	-- dap.configurations["mojo"] = {
	-- 	{
	-- 		name = "Launch",
	-- 		type = "lldb",
	-- 		request = "launch",
	-- 		program = "${file}",
	-- 		-- program = function()
	-- 		-- 	---@diagnostic disable-next-line: redundant-parameter
	-- 		-- 	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 		-- end,
	-- 		cwd = "${workspaceFolder}",
	-- 		stopOnEntry = false,
	-- 		args = {},
	-- 	},
	-- }
end

return M
