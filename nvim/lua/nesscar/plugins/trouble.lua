return {
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    config = function()
      require("trouble").setup({
        -- Minimal setup that works well with tiny-inline-diagnostic
        modes = {
          diagnostics = {
            focus = true,
          },
        },
      })

      -- Keymaps for common Trouble actions (v2+ uses "Trouble" command)
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Diagnostics" })
      vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Toggle Location List" })
      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Toggle Quickfix" })
      vim.keymap.set("n", "gR", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP References (Trouble)" })
    end,
  },
}
