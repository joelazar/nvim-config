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

    -- Update the pretty_path component to not truncate filenames
    -- Replace the existing pretty_path component in lualine_c
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
  end,
}