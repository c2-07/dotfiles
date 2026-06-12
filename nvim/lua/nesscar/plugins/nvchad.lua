return {
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    priority = 10000,
  },

  {
    "NvChad/base46",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
      
      if not vim.uv.fs_stat(vim.g.base46_cache) then
        require("base46").compile()
      end
      
      require("base46").load_all_highlights()

      -- Dynamic Cursor Color: match cursor to theme accent
      local function apply_cursor_color()
        local accent_hl = vim.api.nvim_get_hl(0, { name = "Function", link = false })
        if not accent_hl or not accent_hl.fg then
          accent_hl = vim.api.nvim_get_hl(0, { name = "Function", link = true })
        end

        if accent_hl and accent_hl.fg then
          vim.api.nvim_set_hl(0, "Cursor", { bg = accent_hl.fg, fg = "#000000" })
          vim.api.nvim_set_hl(0, "TermCursor", { bg = accent_hl.fg, fg = "#000000" })
          vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
        end
      end

      apply_cursor_color()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_cursor_color })
    end,
  },

  {
    "NvChad/ui",
    lazy = false,
    priority = 900,
    dependencies = { "NvChad/volt", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvchad")
      require("nvchad.colorify").run()
    end,
  },

  {
    "NvChad/nvterm",
    lazy = false,
    config = function() require("nvterm").setup() end,
  },
}
