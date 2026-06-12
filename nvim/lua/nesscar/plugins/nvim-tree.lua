return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = function()
    local conf = require "nvchad.configs.nvimtree"
    
    -- Disable all git features
    conf.git = {
      enable = false,
      ignore = true,
    }
    
    -- Clean up the renderer
    conf.renderer.highlight_git = false
    conf.renderer.icons.show = {
      git = false,
      folder = true,
      file = true,
      folder_arrow = true,
    }
    
    -- Ensure glyphs are clean
    conf.renderer.icons.glyphs = conf.renderer.icons.glyphs or {}
    conf.renderer.icons.glyphs.git = {
      unstaged = "",
      staged = "",
      unmerged = "",
      renamed = "",
      untracked = "",
      deleted = "",
      ignored = "",
    }
    
    return conf
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
