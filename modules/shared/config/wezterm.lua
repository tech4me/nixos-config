local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Monokai Soda'
config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 14.0

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_background_opacity = 0.96
config.macos_window_background_blur = 20

return config