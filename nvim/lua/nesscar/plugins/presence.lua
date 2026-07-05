return {
  "vyfor/cord.nvim",
  opts = {
    editor = {
      client = "neovim",
      tooltip = "Neovim",
    },

    display = {
      theme = "atom",
      flavor = "dark",
    },

    text = {
      workspace = function(opts)
        return opts.workspace
      end,
    },
  },
}
