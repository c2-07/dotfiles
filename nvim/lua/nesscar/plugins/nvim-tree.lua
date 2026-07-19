return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    filters = { dotfiles = false },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = false,
      ignore = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    renderer = {
      root_folder_label = false,
      highlight_git = false,
      indent_markers = { enable = true },
      icons = {
        show = {
          git = false,
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local function open_nvim_tree(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      if not directory and not no_name then
        return
      end

      if directory then
        vim.cmd.cd(data.file)
      end
      require("nvim-tree.api").tree.open()
    end

    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  end,
}
