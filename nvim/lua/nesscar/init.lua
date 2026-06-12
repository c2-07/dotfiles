require("nesscar.lazy")
require("nesscar.keymaps")
require("nesscar.options")
require("nesscar.config")
require("nesscar.neovide")

-- Shorten terminal buffer names for cleaner UI (Dropbar/Lualine)
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local name = vim.api.nvim_buf_get_name(0)
    if name:match("term://") then
      local cwd = name:match("term://(.-)//")
      local shell = name:match(".*/(.-)$")
      if shell then shell = shell:gsub(";#toggleterm#%d+", "") end
      local term_id = name:match("#toggleterm#(%d+)")

      -- Shorten path if in home
      if cwd then
        cwd = cwd:gsub(vim.env.HOME, "~")
      end

      local new_name = (cwd or "Term") .. " - " .. (shell or "sh")
      if term_id then new_name = new_name .. " #" .. term_id end

      -- Use pcall to avoid errors if name already exists
      pcall(vim.api.nvim_buf_set_name, 0, new_name)
    end
  end,
})
