return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local function get_lualine_theme()
      local ok, base46 = pcall(require, "base46")
      if not ok then
        return "auto"
      end

      local colors = base46.get_theme_tb("base_30")
      if not colors then
        return "auto"
      end

      local black = "#222222"
      local dark_gray = colors.one_bg or "#151515"
      local white = "#aeb6c4"

      local shades = {
        normal = colors.blue,
        insert = colors.green,
        visual = colors.purple,
        replace = colors.red,
        command = colors.yellow,
        terminal = colors.purple,
      }

      local theme = {
        inactive = {
          a = { fg = colors.light_grey, bg = black, gui = "bold" },
          b = { fg = colors.light_grey, bg = black },
          c = { fg = colors.light_grey, bg = black },
        },
      }

      for mode, accent in pairs(shades) do
        theme[mode] = {
          a = { fg = black, bg = accent, gui = "bold" },
          b = { fg = white, bg = dark_gray },
          c = { fg = white, bg = black },
          z = { fg = black, bg = accent, gui = "bold" },
        }
      end

      return theme
    end

    local function setup_lualine()
      local ok, base46 = pcall(require, "base46")
      local colors = ok and base46.get_theme_tb("base_30") or {}

      local dark_gray = colors.one_bg or "#151515"

      local function not_terminal()
        return vim.bo.buftype ~= "terminal"
      end

      local function is_terminal()
        return vim.bo.buftype == "terminal"
      end

      require("lualine").setup({
        options = {
          theme = get_lualine_theme(),
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },

        sections = {
          lualine_a = {
            { "mode", padding = { left = 2, right = 2 } },
          },

          lualine_b = {},

          lualine_c = {
            {
              function()
                return ""
              end,
              cond = is_terminal,
            },

            {
              "filename",
              cond = not_terminal,
              path = 0,

              fmt = function(str)
                if vim.bo.filetype == "NvimTree" then
                  return ""
                end
                return str
              end,

              symbols = {
                modified = "",
                readonly = " 󰌾",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
            {
              "diagnostics",
              cond = not_terminal,
              symbols = {
                error = " ",
                warn = "! ",
                info = "𝗂 ",
                hint = "󰌵 ",
              },
              separator = "|",
              color = { bg = dark_gray },
            },
          },

          lualine_x = {
            {
              "diff",
              cond = not_terminal,
              symbols = {
                added = "+",
                modified = "~",
                removed = "-",
              },
              diff_color = {
                added = { fg = colors.green or "#98be65" },
                modified = { fg = colors.orange or "#da8548" },
                removed = { fg = colors.red or "#ff6c6b" },
              },
              separator = "|",
              color = { bg = dark_gray },
            },
            {
              "branch",
              cond = not_terminal,
              icon = "",
              separator = "|",
              color = { bg = dark_gray },
            },
            -- {
            --   "filetype",
            --   icons_enabled = false,
            --   icon_only = false,
            --   icon = nil,
            --   colored = false,
            --   fmt = string.upper,
            --   color = { bg = dark_gray },
            -- },
          },

          lualine_y = {
            {
              "progress",
              cond = not_terminal,
              padding = { left = 1, right = 2 },
            },
          },

          lualine_z = {
            {
              "location",
              padding = { left = 2, right = 2 },
            },
          },
        },
      })
    end

    setup_lualine()

    vim.api.nvim_create_autocmd("User", {
      pattern = "NvThemeReload",
      callback = function()
        setup_lualine()
      end,
    })
  end,
}
