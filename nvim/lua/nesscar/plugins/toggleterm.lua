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
  end,
}
