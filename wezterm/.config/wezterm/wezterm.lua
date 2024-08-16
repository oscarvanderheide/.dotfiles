-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'nord'
-- Change default font (needed for powerlevel10k)
config.font = wezterm.font('MesloLGS Nerd Font Mono')
--config.font = wezterm.font('GohuFont uni14 Nerd Font Mono')
config.font_size = 16

-- Disable the macOS traffic light
config.window_decorations = "RESIZE"
-- Have macOS traffic light buttons next to the tabs instead
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- Monospace tab bar font
config.use_fancy_tab_bar = false

-- Disable annoying exit confirmations
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"

-- Set initial columns and rows to large values
config.initial_cols = 128
config.initial_rows = 38

-- Keyboard shortcuts

config.keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
    -- Make Cmd-Left move to the start of the line
    {key = 'LeftArrow', mods = 'CMD', action = wezterm.action { SendString = "\x1bOH"}},
    -- Make Cmd-Right move to the end of the line
    {key = 'RightArrow', mods = 'CMD', action = wezterm.action { SendString = "\x1bOF"}}
}

-- and finally, return the configuration to wezterm
return config
