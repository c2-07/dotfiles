return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  config = function()
    local fff = require("fff")

    -- Keymaps
    vim.keymap.set("n", "<leader>ff", fff.find_files, { desc = "fff: Find files" })
    vim.keymap.set("n", "<leader><leader>", fff.find_files, { desc = "fff: Find files" })

    vim.keymap.set("n", "<leader>gr", fff.refresh_git_status, { desc = "fff: Refresh Git" })

    -- FFF Setup
    fff.setup({
      -- Core
      prompt = " > ",
      title = "Find Files", -- no title = cleaner
      max_results = 15,
      lazy_sync = true,

      layout = {
        height = 0.45, -- smaller container
        width = 0.5,
        prompt_position = "top",
      },

      -- No preview
      preview = {
        enabled = false,
      },

      -- Minimal UI
      icons = { enabled = true },
      git = { status_text_color = true },

      -- Optional: keep or kill history
      history = {
        enabled = true,
      },
    })
  end,
}
