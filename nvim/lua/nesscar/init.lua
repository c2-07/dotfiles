require("nesscar.options")
require("nesscar.keymaps")
require("nesscar.lazy")
require("nesscar.config")
require("nesscar.neovide")
require("nesscar.theme_manager").setup()

-- Apply colorscheme
vim.cmd.colorscheme(vim.g.theme)
