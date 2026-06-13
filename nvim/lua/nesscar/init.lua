require("nesscar.lazy")
require("nesscar.keymaps")
require("nesscar.options")
require("nesscar.config")
require("nesscar.neovide")
require("nesscar.theme_manager").setup()

-- Apply colorscheme
vim.cmd.colorscheme(vim.g.theme)
