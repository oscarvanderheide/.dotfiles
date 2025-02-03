return function(config)
	local wezterm = require("wezterm")

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
		-- },
		-- 	action = sessionizer.show,
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
