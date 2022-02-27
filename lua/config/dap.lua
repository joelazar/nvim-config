local M = {}

M.setup = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end

	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/dapinstall/jsnode_dbg/" .. "/vscode-node-debug2/out/src/nodeDebug.js",
		},
	}

	dap.configurations.javascript = {
		{
			type = "node2",
			request = "launch",
			program = "${workspaceFolder}/${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}

	dap.configurations.typescript = {
		{
			type = "node2",
			request = "launch",
			program = "${workspaceFolder}/${file}",
			cwd = vim.fn.getcwd(),
			preLaunchTask = "tsc: build - tsconfig.json",
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}

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
end

return M
