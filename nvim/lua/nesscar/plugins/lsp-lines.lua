return {
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			-- Disable virtual_text since it's redundant due to lsp_lines.
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = { only_current_line = true },
			})

			-- Toggle keymap
			vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
		end,
	},
}
