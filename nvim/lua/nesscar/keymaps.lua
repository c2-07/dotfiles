local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- General
map("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  vim.cmd("noh")
end, { silent = true })

map("n", "c", '"_c', opts)
map("x", "p", "P", opts)

-- File Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- LSP
map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })
map("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "References" })
map("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "Implementation" })
map("n", "gy", function()
  vim.lsp.buf.type_definition()
end, { desc = "Type Definition" })
map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "Hover Docs" })
map("n", "gK", function()
  vim.lsp.buf.signature_help()
end, { desc = "Signature Help" })
map("i", "<C-k>", function()
  vim.lsp.buf.signature_help()
end, { desc = "Signature Help" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action" })
map("n", "<leader>ra", function()
  vim.lsp.buf.rename()
end, { desc = "Rename" })

-- Diagnostics
map("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, {
    focus = false,
    close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
  })
end)

-- Formatting
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = false })
end, { desc = "Format file (conform)" })

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({ async = true })
end, {})

-- Buffers
map("n", "bn", ":bnext<CR>")
map("n", "bp", ":bprevious<CR>")
map("n", "bd", "<cmd>bd<CR>")
map("n", "<leader>x", "<cmd>bd<CR>")

-- Windows
map("n", "<leader>\\", "<cmd>vsplit<CR>", opts)
map("n", "<leader>-", "<cmd>split<CR>", opts)
map("n", "<C-w>x", "<cmd>close<CR>", opts)
map("n", "<C-w>o", "<cmd>only<CR>", opts)
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Git
map("n", "<leader>gd", ":Gitsigns preview_hunk_inline<CR>")

-- Toggle terminal
map({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<CR>", {
  desc = "Toggle Terminal",
})

-- Neovide
if vim.g.neovide then
  map({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", opts)
  map({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", opts)
  map({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", opts)
  map("c", "<C-v>", "<C-r>+")
  map("c", "<D-v>", "<C-r>+")
  map("i", "<D-v>", "<C-r>+")
end
