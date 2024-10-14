-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
scheme = "nord"
local scheme_def = wezterm.color.get_builtin_schemes()[scheme]

config.color_scheme = scheme
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = scheme_def.background,
			fg_color = scheme_def.foreground,
		},
	},
}

-- Change default font (needed for powerlevel10k)
-- config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12

-- Disable the macOS traffic light
config.window_decorations = "RESIZE"

-- Have macOS traffic light buttons next to the tabs instead
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

-- Monospace tab bar font
config.use_fancy_tab_bar = false

-- Disable annoying exit confirmations
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Set initial columns and rows to large values
config.initial_cols = 128
config.initial_rows = 38

-- Keyboard shortcuts
config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- Make Cmd-Left move to the start of the line
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOH" }) },
	-- Make Cmd-Right move to the end of the line
	{ key = "RightArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOF" }) },
	-- Don't confirm upon closing tab
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	-- Use CMD + SHIFT + \ to split horizontally
	{ key = "\\", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- Cycle to the next pane
	{ key = "[", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
	-- Cycle to the previous pane
	{ key = "]", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
}

-- SSH stuff
config.ssh_domains = {
	{
		-- This name identifies the domain
		name = "roodnoot",
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = "roodnoot",
		-- The username to use on the remote host
		username = "oheide",
	},
}

return config
