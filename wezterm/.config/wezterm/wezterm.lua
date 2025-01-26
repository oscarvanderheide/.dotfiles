-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Plugins
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- The configuration is is grouped into categories using do .. end blocks

-------- APPEARANCE --------
do
	-- Set the color scheme
	local scheme = "nord"
	config.color_scheme = scheme

	-- Make the tab bar have the same color scheme
	local scheme_def = wezterm.color.get_builtin_schemes()[scheme]
	config.colors = {
		tab_bar = {
			background = scheme_def.background,
			active_tab = {
				bg_color = scheme_def.background,
				fg_color = scheme_def.foreground,
			},
		},
	}

	-- Disable the macOS traffic light but keep resizable border
	config.window_decorations = "RESIZE"

	-- Change default font
	config.font = wezterm.font({
		family = "JetBrains Mono",
		weight = "DemiBold",
	})
	config.font_size = 12

	-- Set opacity and background blur
	-- config.window_background_opacity = 0.999
	-- config.macos_window_background_blur = 25

	-- Alternative: give wezterm itself a background image
	config.background = {
		-- {
		-- 	source = { File = "/Users/oscar/Downloads/bloem.jpg" },
		-- 	hsb = { hue = 1.0, saturation = 0.82, brightness = 0.35 },
		-- 	width = "100%",
		-- 	height = "100%",
		-- },
		{ source = { Color = "#282c35" }, width = "100%", height = "100%", opacity = 1.00 },
	}
	-- Monospace tab bar font
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = false

	-- Set initial columns and rows to large values
	config.initial_cols = 128
	config.initial_rows = 38

	-- Position tab bar at the bottom instead of top
	config.tab_bar_at_bottom = true

	-- I don't like putting anything at the edge if I can help it.
	config.enable_scroll_bar = true
	config.window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 10,
	}

	-- Increase fps
	config.max_fps = 120
end

---- TECHNICAL STUFF -------------
do
	-- Required to make Cmd + , open this config in nvim (keybind defined further below)
	config.set_environment_variables = {
		PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
	}
	-- Something to enable Cmd as modifier key in nvim
	config.enable_kitty_keyboard = true
	config.enable_csi_u_key_encoding = false

	-- Makes text look sharper and clearer on most LCD screens (not sure wtf this does)
	config.freetype_load_target = "HorizontalLcd"

	-- Disable annoying exit confirmations
	config.window_close_confirmation = "NeverPrompt"
	config.exit_behavior = "Close"

	-- No more window resizing when changing font size
	config.adjust_window_size_when_changing_font_size = false
end

-- PLUGINS
do
	-- Presentation mode
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

	-- Sessionizer

	--
end
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
local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
sessionizer.apply_to_config(config)
--
sessionizer.config = {
	-- Only shows git repositories in the sessionizer
	paths = {
		"/Users/oscar/.julia/dev", -- this could for example be "/home/<your_username>/dev"
		"/Users/oscar/.dotfiles",
		"/Users/oscar/tmp",
	},
	command_options = {
		fd_path = "/opt/homebrew/bin/fd",
	},
	-- keys = {
	-- 	{
	-- 		key = "r",
	-- 		mods = "OPT",
	-- 		action = sessionizer.show,
	-- 	},
	-- 	{
	-- 		key = ".",
	-- 		mods = "OPT",
	-- 		action = sessionizer.switch_to_most_recent,
	-- 	},
	-- },
}

-- config.status_update_interval = 100
-- Update the workspace name based on the current directory
wezterm.on("update-right-status", function(window, pane)
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = cwd_uri.file_path
		local workspace_name = cwd:match("([^/]+)$")
		wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), workspace_name)
	end
end)

-- ======== KEYMAPS ========
do
	config.keys = {
		-- Shortcut for starting a new workspace
		{
			key = "T",
			mods = "CMD|SHIFT",
			action = wezterm.action.SwitchToWorkspace,
		},
		-- Shortcut for listing and switching workspaces
		{
			key = "L",
			mods = "CMD|SHIFT",
			action = wezterm.action.ShowLauncherArgs({
				flags = "WORKSPACES",
			}),
		},
		-- {
		-- 	key = "s",
		-- 	mods = "CMD|SHIFT",
		-- 	action = sessionizer.show,
		-- },
		-- {
		-- 	key = "l",
		-- 	mods = "CMD|SHIFT",
		-- 	action = seossionizer.switch_to_most_recent,
		-- },
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		-- Make Cmd-Left move to the start of the line
		{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOH" }) },
		-- Make Cmd-Right move to the ending of the line
		{ key = "RightArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOF" }) },
		-- Don't confirm upon closing tab
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		-- Use CMD + SHIFT + \ to split horizontally
		{ key = "\\", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- Use CMD + SHIFT + - to split horizontally
		{ key = "-", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- Cycle to the next pane
		{ key = "[", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
		-- Cycle to the previous pane
		{ key = "]", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
		-- Open Wezterm's config with Cmd + ,
		{
			key = ",",
			mods = "CMD",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.config_file },
			}),
		},
		{
			key = "X",
			mods = "CMD",
			action = wezterm.action.ActivateCopyMode,
		},
	}
end

-- Change the background of tabline_c section for normal mode
tabline.setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = {},
		tabline_y = {},
		-- tabline_x = { "ram", "cpu" },
		-- tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
	extensions = {},
})

return config
