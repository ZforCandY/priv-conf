-- Wezterm API
local wezterm = require 'wezterm'

-- Hold the configuration.
local config = wezterm.config_builder()

-- Config choices.
config.window_background_opacity = 1
config.front_end = 'WebGpu'
config.animation_fps = 60
config.max_fps = 60
-- config_scrollback_line = 9999
use_dead_keys = false
allow_win32_input_mode = true
config.default_prog = { 'powershell.exe', '-NoLogo' }
local theme_rotator = wezterm.plugin.require 'https://github.com/koh-sh/wezterm-theme-rotator'

-- Key
local leader = {
	key = ':',
	mods = 'SUPER|SHIFT',
	timeout_milliseconds = math.maxinteger
}
config.keys = {
    { key = '|', mods = 'SHIFT|ALT', action = wezterm.action.SplitHorizontal },
    { key = '_', mods = 'SHIFT|ALT', action = wezterm.action.SplitVertical },
    { key = 'i', mods = 'SHIFT|ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'k', mods = 'SHIFT|ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'j', mods = 'SHIFT|ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'SHIFT|ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'd', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentPane { confirm = false }
    },
    { key = 'LeftArrow', mods = 'SHIFT|ALT', action = wezterm.action.ActivatePaneDirection 'Left'},
    { key = 'RightArrow',mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right'},
    { key = 'UpArrow',   mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up'},
    { key = 'DownArrow', mods = 'ALT|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down'},
}

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- Geometry for new windows:
-- config.initial_cols = 200
-- config.initial_rows = 50

-- Dim inactive pane
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

-- Font size and color scheme.
config.font_size = 25
config.color_scheme = 'Paper (Gogh)'

theme_rotator.apply_to_config(config, {
     -- "Random Theme" key
  random_theme_key = '/',
  random_theme_mods = 'SHIFT|ALT',

  -- "Default Theme" key
  default_theme_key = '*',
  default_theme_mods = 'SHIFT|ALT',
})

-- wezterm.plugin.update_all()
-- Finally, return the configuration to wezterm:
return config
