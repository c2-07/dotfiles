return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        devicon = true,
        foldericon = true,
        title = true,
        expand = "⊞",
        collapse = "⊟",
        code_action = "",
        actionfix = " ",
        lines = { "┗", "┣", "┃", "━", "┏" },
        kind = nil,
      },
      hover = {
        max_width = 0.6,
        open_link = "gx",
        open_cmd = "!chrome",
      },
      outline = {
        win_width = 30,
        win_position = "right",
        keys = {
          jump = "e",
          quit = "q",
          expand_collapse = "u",
        },
      },
      symbol_in_winbar = {
        enable = false,
      },
    })

    -- Keymaps for LSPSaga
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
    vim.keymap.set("n", "<leader>ra", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Doc" })
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Toggle Outline" })
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go to Definition" })
    vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", { desc = "Find References" })
  end,
}
