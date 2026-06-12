return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      -- Only use ctrl+/ to toggle
      open_mapping = [[<C-/>]],
      float_opts = {
        border = "rounded",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.7),
      },
    })
    
    -- Ensure <C-_> also works (many terminals send Ctrl+/ as Ctrl+_)
    vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
  end,
}
