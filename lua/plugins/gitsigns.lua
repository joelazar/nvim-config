return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]h", function()
				if vim.wo.diff then
					return "]h"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next hunk" })

			map("n", "[h", function()
				if vim.wo.diff then
					return "[h"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous hunk" })

			-- Actions
			map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
			map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
			map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
			map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview hunk" })

			map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame line" })
			map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, { desc = "Diff this against parent" })

			map("n", "<leader>TB", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
			map("n", "<leader>TD", gs.toggle_deleted, { desc = "Toggle deleted" })

			-- Text object
			map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
		end,
	},
}
