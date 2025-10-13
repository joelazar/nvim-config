-- url-to-markdown.lua
-- Converts URLs to markdown links with fetched page titles (async)

local M = {}

-- Track active conversions
local active_conversions = {}

-- Fetch title from URL asynchronously
local function fetch_title_async(url, callback)
  local curl_cmd = {
    "curl",
    "-sL",
    "--max-time",
    "10", -- 10 second timeout
    url,
  }

  vim.system(curl_cmd, {
    text = true,
    timeout = 10000, -- 10 seconds
  }, function(result)
    vim.schedule(function()
      if result.code == 0 and result.stdout then
        -- Extract title from HTML
        local title = result.stdout:match("<title[^>]*>([^<]*)</title>")
        if title then
          title = title:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", " ")
          -- Decode common HTML entities
          title = title:gsub("&amp;", "&"):gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&quot;", '"'):gsub("&#39;", "'")
        end
        callback(title ~= "" and title or nil)
      else
        callback(nil)
      end
    end)
  end)
end

-- Convert URL under cursor to markdown link
function M.url_to_markdown()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local buf = vim.api.nvim_get_current_buf()

  -- Find URL pattern
  local url_pattern = "https?://[%w-._~:/?#%[%]@!$&'()*+,;=%%]+"
  local url_start, url_end = nil, nil

  for start, finish in line:gmatch("()" .. url_pattern .. "()") do
    if start - 1 <= col and col < finish - 1 then
      url_start = start
      url_end = finish - 1
      break
    end
  end

  if not url_start then
    vim.notify("No URL found under cursor", vim.log.levels.WARN)
    return
  end

  local url = line:sub(url_start, url_end)

  -- Create unique key for this conversion
  local conversion_key = string.format("%d:%d:%d:%s", buf, line_num, url_start, url)

  -- Check if this exact conversion is already in progress
  if active_conversions[conversion_key] then
    vim.notify("Conversion already in progress for this URL", vim.log.levels.INFO)
    return
  end

  -- Mark as active
  active_conversions[conversion_key] = true

  -- Show progress
  vim.notify("Fetching title for: " .. (url:len() > 50 and url:sub(1, 50) .. "..." or url), vim.log.levels.INFO)

  -- Fetch title asynchronously
  fetch_title_async(url, function(title)
    -- Remove from active conversions
    active_conversions[conversion_key] = nil

    -- Check if buffer and line still exist and are unchanged
    if not vim.api.nvim_buf_is_valid(buf) then
      vim.notify("Buffer no longer valid", vim.log.levels.WARN)
      return
    end

    local current_line = vim.api.nvim_buf_get_lines(buf, line_num - 1, line_num, false)[1]
    if not current_line then
      vim.notify("Line no longer exists", vim.log.levels.WARN)
      return
    end

    -- Check if the URL is still at the expected position
    local current_url = current_line:sub(url_start, url_end)
    if current_url ~= url then
      vim.notify("URL has changed, skipping conversion", vim.log.levels.WARN)
      return
    end

    -- Use URL as fallback title
    if not title then
      title = url
      vim.notify("Could not fetch title, using URL", vim.log.levels.WARN)
    end

    -- Create markdown link
    local md_link = string.format("[%s](%s)", title, url)

    -- Replace URL with markdown link
    local new_line = current_line:sub(1, url_start - 1) .. md_link .. current_line:sub(url_end + 1)
    vim.api.nvim_buf_set_lines(buf, line_num - 1, line_num, false, { new_line })

    vim.notify("✓ Converted to markdown link", vim.log.levels.INFO)
  end)
end

-- Setup function
function M.setup(opts)
  opts = opts or {}

  -- Create command
  vim.api.nvim_create_user_command("UrlToMarkdown", M.url_to_markdown, {})

  -- Optional: Set up default keybinding
  if opts.keybind then
    vim.keymap.set("n", opts.keybind, M.url_to_markdown, { desc = "Convert URL to markdown link" })
  end
end

return M
