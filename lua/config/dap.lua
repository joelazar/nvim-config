local M = {}

M.setup = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end

	vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/git/js/vscode-firefox-debug/dist/adapter.bundle.js" },
	}

	dap.configurations.typescript = {
		{
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/usr/bin/firefox",
		},
	}
	dap.configurations.typescriptreact = dap.configurations.typescript
	dap.configurations.javascript = dap.configurations.typescript
	dap.configurations.javascriptreact = dap.configurations.typescript

	dap.adapters.go = function(callback, config)
		local handle, pid_or_err, port = nil, nil, 12346

		handle, pid_or_err = vim.loop.spawn(
			"dlv",
			{
				args = { "dap", "-l", "127.0.0.1:" .. port },
				detached = true,
				cwd = vim.loop.cwd(),
			},
			vim.schedule_wrap(function(code)
				handle:close()
				print("Delve has exited with: " .. code)
			end)
		)

		if not handle then
			error("FAILED:", pid_or_err)
		end

		vim.defer_fn(function()
			callback({ type = "server", host = "127.0.0.1", port = port })
		end, 100)
	end

	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			showLog = true,
			program = "${file}",
			-- console = "externalTerminal",
			dlvToolPath = vim.fn.exepath("dlv"),
		},
		{
			name = "Test Current File",
			type = "go",
			request = "launch",
			showLog = true,
			mode = "test",
			program = ".",
			dlvToolPath = vim.fn.exepath("dlv"),
		},
	}

	-- TODO - not tested
	dap.configurations.python = {
		{
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
		},
	}
end

return M
