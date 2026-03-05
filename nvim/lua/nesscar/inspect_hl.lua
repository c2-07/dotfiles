local groups = { "Normal", "Title", "Comment", "Constant", "String", "Function", "Statement", "Type", "Special", "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
for _, g in ipairs(groups) do
  local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
  print(g .. ": " .. vim.inspect(hl))
end
