return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local map = vim.keymap.set

    map("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Harpoon Add" })

    map("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        ui_width_ratio = 0.4,
        height_in_lines = math.floor(vim.o.lines * 0.30),
      })
    end, { desc = "Harpoon Menu" })

    map("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Harpoon Next" })

    map("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Harpoon Prev" })

    map("n", "<leader>hd", function()
      harpoon:list():remove()
    end, { desc = "Harpoon Delete" })

    for i = 1, 5 do
      map("n", "<leader>" .. i, function()
        harpoon:list():select(i)
      end, { desc = "Harpoon " .. i })
    end
  end,
}
