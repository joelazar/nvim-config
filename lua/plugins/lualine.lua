-- Lualine word count extension
-- Shows word count in the status line for text files
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local function is_textfile()
      local filetype = vim.bo.filetype
      return filetype == "markdown"
        or filetype == "asciidoc"
        or filetype == "pandoc"
        or filetype == "tex"
        or filetype == "text"
    end

    local function wordcount()
      local wc = vim.fn.wordcount()
      local visual_words = wc.visual_words or wc.words
      local word_string = visual_words == 1 and " word" or " words"
      return tostring(visual_words) .. word_string
    end

    table.insert(opts.sections.lualine_z, { wordcount, cond = is_textfile })

    local function obsidian_status()
      return package.loaded["obsidian.sync.status"]
    end
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return obsidian_status().icon()
      end,
      color = function()
        local status = obsidian_status()
        return status and status.color()
      end,
      cond = function()
        local status = obsidian_status()
        return status ~= nil and status.cond()
      end,
    })

    -- Native diagnostic status
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return vim.diagnostic.status() or ""
      end,
    })

    -- Native LSP progress status
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return vim.ui.progress_status() or ""
      end,
    })

    -- Update the pretty_path component to not truncate filenames
    -- Replace the existing pretty_path component in lualine_c
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
  end,
}
