return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "float",
    shade_terminals = false,
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.7)
      end,
      winblend = 0,
    },
  },
}
