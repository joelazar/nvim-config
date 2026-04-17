-- Returns true if we should skip bullet creation:
-- next line is empty AND the line after that is NOT a header (or end of file)
local function should_skip_bullet()
  local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-indexed
  local line_count = vim.api.nvim_buf_line_count(0)
  if row >= line_count then
    return false
  end
  local next_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if not next_line or not next_line:match("^%s*$") then
    return false -- next line is not empty, don't skip
  end
  -- Next line is empty — check if the line after that is a header
  if row + 1 < line_count then
    local line_after = vim.api.nvim_buf_get_lines(0, row + 1, row + 2, false)[1]
    if line_after and line_after:match("^#+ ") then
      return false -- line after empty line is a header, allow bullet
    end
  end
  return true -- empty line followed by non-header or EOF, skip bullet
end

return {
  "gaoDean/autolist.nvim",
  ft = { "markdown" },
  opts = {},
  keys = {
    {
      "<CR>",
      function()
        -- Check BEFORE the CR is processed whether the line below cursor is empty
        local skip = should_skip_bullet()
        -- Insert the newline
        local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        vim.api.nvim_feedkeys(cr, "n", false)
        if not skip then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Cmd>AutolistNewBullet<CR>", true, false, true), "n", false)
        end
      end,
      ft = "markdown",
      mode = "i",
    },
    { "<TAB>", "<cmd>AutolistTab<cr>", ft = "markdown", mode = "i" },
    { "<S-TAB>", "<cmd>AutolistShiftTab<cr>", ft = "markdown", mode = "i" },
  },
}
