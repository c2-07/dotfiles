-- neovide settings
vim.g.neovide_opacity = 0.90
vim.g.neovide_normal_opacity = 0.94
vim.g.neovide_cursor_animation_length = 0.2
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_vfx_opacity = 50.0
vim.g.neovide_cursor_vfx_particle_density = 0.5
vim.g.neovide_scroll_animation_length = 0.2

-- Padding
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_left = 10
vim.g.neovide_padding_right = 10

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_frame = "none"
vim.o.guifont = "JetBrainsMono Nerd Font:h16"

-- macOS specific Neovide settings
if vim.g.neovide then
  vim.g.neovide_input_use_logo = true -- use apple/logo key for command
end

vim.g.neovide_message_area_drag_selection = true
