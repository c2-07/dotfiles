local parser = vim.treesitter.get_parser(0, 'lua')
local tree = parser:parse()[1]
local root = tree:root()
local r1 = root:range()
local ok, err = pcall(function() return root:range(true) end)
print(err)
