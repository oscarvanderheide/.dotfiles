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
		background = scheme_def.background,
		active_tab = {
			bg_color = scheme_def.background,
			fg_color = scheme_def.foreground,
		},
	},
}

-- Something to enable Cmd as modifier key in nvim
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

-- Change default font (needed for powerlevel10k)
-- config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

-- Disable the macOS traffic light
config.window_decorations = "RESIZE"

-- Have macOS traffic light buttons next to the tabs instead
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10

-- Monospace tab bar font
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
-- Disable annoying exit confirmations
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 10,
}

config.tab_bar_at_bottom = false
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
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- Use CMD + SHIFT + \ to split horizontally
	{ key = "\\", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- Cycle to the next pane
	{ key = "[", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
	-- Cycle to the previous pane
	{ key = "]", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
}

-- you may also use the "https://github.com/Xarvex/presentation.wez" mirror
wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez").apply_to_config(config, {
	font_size_multiplier = 1.8, -- sets for both "presentation" and "presentation_full"
	presentation = {
		keybind = { key = "t", mods = "ALT" }, -- setting a keybind
	},
	presentation_full = {
		font_weight = "Bold",
		font_size_multiplier = 2.4, -- overwrites "font_size_multiplier" for "presentation_full"
	},
})
--
-- -- local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
-- -- Change the background of tabline_c section for normal mode
-- -- tabline.setup({
-- -- 	options = {
-- -- 		icons_enabled = true,
-- -- 		theme = "Catppuccin Mocha",
-- -- 		-- theme = "Nord",
-- -- 		color_overrides = {},
-- -- 		section_separators = {
-- -- 			left = "", -- wezterm.nerdfonts.pl_left_hard_divider,
-- -- 			right = "", -- wezterm.nerdfonts.pl_right_hard_divider,
-- -- 		},
-- -- 		component_separators = {
-- -- 			left = "", -- wezterm.nerdfonts.pl_left_soft_divider,
-- -- 			right = "", -- wezterm.nerdfonts.pl_right_soft_divider,
-- -- 		},
-- -- 		tab_separators = {
-- -- 			left = "", -- wezterm.nerdfonts.pl_left_hard_divider,
-- -- 			right = "", -- wezterm.nerdfonts.pl_right_hard_divider,
-- -- 		},
-- -- 	},
-- -- 	sections = {
-- -- 		tabline_a = { "" },
-- -- 		tabline_b = { "" },
-- -- 		tabline_c = { "" },
-- -- 		tab_inactive = { "" },
-- -- 		tab_active = {
-- -- 			"index",
-- -- 			{ "parent", padding = 0 },
-- -- 			"/",
-- -- 			{ "cwd", padding = { left = 0, right = 1 } },
-- -- 			{ "zoomed", padding = 0 },
-- -- 		},
-- -- 		-- tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
-- -- 		tabline_x = { "" },
-- -- 		tabline_y = { "" },
-- -- 		tabline_z = { "workspace" },
-- -- 	},
-- -- 	extensions = {},
-- -- })
-- -- tabline.apply_to_config(config)
--
-- -- SSH stuff
-- config.ssh_domains = {
-- 	{
-- 		-- This name identifies the domain
-- 		name = "roodnoot",
-- 		-- The hostname or address to connect to. Will be used to match settings
-- 		-- from your ssh config file
-- 		remote_address = "roodnoot",
-- 		-- The username to use on the remote host
-- 		username = "oheide",
-- 	},
-- }
--
-- local act = wezterm.action
--
-- wezterm.on("update-right-status", function(window, pane)
-- 	window:set_right_status(window:active_workspace())
-- end)
--
-- config.keys = {
-- 	-- Prompt for a name to use for a new workspace and switch to it.
-- 	{
-- 		key = "N",
-- 		mods = "CMD|SHIFT",
-- 		action = act.PromptInputLine({
-- 			description = wezterm.format({
-- 				{ Attribute = { Intensity = "Bold" } },
-- 				{ Foreground = { AnsiColor = "Fuchsia" } },
-- 				{ Text = "Enter name for new workspace" },
-- 			}),
-- 			action = wezterm.action_callback(function(window, pane, line)
-- 				-- line will be `nil` if they hit escape without entering anything
-- 				-- An empty string if they just hit enter
-- 				-- Or the actual line of text they wrote
-- 				if line then
-- 					window:perform_action(
-- 						act.SwitchToWorkspace({
-- 							name = line,
-- 						}),
-- 						pane
-- 					)
-- 				end
-- 			end),
-- 		}),
-- 	},
-- }
--
-- -- Workspace switcher plugin
-- -- local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
-- -- workspace_switcher.apply_to_config(config)
-- -- config.keys = {
-- -- 	{ key = "s", mods = "ALT", action = wezterm.action.ShowLauncher({ flags = "WORKSPACES" }) },
-- -- }
-- -- config.keys = {
-- -- 	{
-- -- 		key = "s",
-- -- 		mods = "ALT",
-- -- 		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
-- -- 	},
-- -- 	{ key = "n", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
-- -- 	{ key = "p", mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },
-- -- }
-- local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
-- sessionizer.apply_to_config(config)
--
-- sessionizer.config = {
-- 	-- Only shows git repositories in the sessionizer
-- 	paths = {
-- 		"/Users/oscar/.julia/dev", -- this could for example be "/home/<your_username>/dev"
-- 		"/Users/oscar/.dotfiles",
-- 		"/Users/oscar/tmp",
-- 	},
-- 	command_options = {
-- 		fd_path = "/opt/homebrew/bin/fd",
-- 	},
-- }
--
-- config.keys = {
-- 	{
-- 		key = "s",
-- 		mods = "ALT",
-- 		action = sessionizer.show,
-- 	},
-- 	{
-- 		key = "s",
-- 		mods = "ALT|SHIFT",
-- 		action = sessionizer.switch_to_most_recent,
-- 	},
-- }
--
-- Increase fps
config.max_fps = 120
return config
