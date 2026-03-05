return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
      -- Disabled winbar to prevent layout shifting ("shaking")
      -- winbar = {}, 
      sections = {
        lualine_a = {
          { "mode", padding = { left = 2, right = 2 } },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            fmt = function(str)
              if str:match("term://") or str:match("toggleterm") then
                return "Terminal"
              end
              return str
            end,
          },
        },
				lualine_x = {
					{ "filetype", colored = false, fmt = string.upper },
				},
        lualine_y = { "progress" },
        lualine_z = {
          { "location", padding = { left = 2, right = 2 } },
        },
      },
    })
  end,
}
