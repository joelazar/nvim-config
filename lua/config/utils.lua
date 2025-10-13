-- Utility functions for elevated privileges operations
local M = {}

---Execute a command with sudo privileges
---@param cmd string The command to execute
---@param print_output boolean Whether to print the command output
---@return boolean success Whether the command executed successfully
M.sudo_exec = function(cmd, print_output)
  -- Prompt for sudo password securely
  local password = vim.fn.inputsecret("Password: ")
  -- Execute command with sudo, using -S to read password from stdin
  local out = vim.fn.system(string.format("/usr/bin/sudo -p '' -S %s", cmd), password)
  -- Check for execution errors
  if vim.v.shell_error ~= 0 then
    print("\r\n")
    print(out)
    return false
  end
  -- Optionally display command output
  if print_output then
    print("\r\n", out)
  end
  return true
end

---Write the current buffer to a file with sudo privileges
---@param tmpfile? string Optional temporary file path
---@param filepath? string Optional target file path (defaults to current buffer's file)
M.sudo_write = function(tmpfile, filepath)
  -- Use system temp file if none provided
  if not tmpfile then
    tmpfile = vim.fn.tempname()
  end
  -- Default to current buffer's file path
  if not filepath then
    filepath = vim.fn.expand("%")
  end
  -- Validate we have a target file path
  if not filepath or #filepath == 0 then
    print("E32: No file name")
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  -- Use dd command to copy with elevated privileges
  local cmd = string.format("dd if=%s of=%s bs=1048576", vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
  -- Write current buffer to temporary file
  vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })
  -- Execute dd command with sudo and handle result
  if M.sudo_exec(cmd, false) then
    print(string.format('\r\n"%s" written', filepath))
    vim.cmd("e!") -- Reload the buffer to reflect changes
  end
  -- Clean up temporary file
  vim.fn.delete(tmpfile)
end

return M
