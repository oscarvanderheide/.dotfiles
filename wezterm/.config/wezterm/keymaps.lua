return function(config)
	local wezterm = require("wezterm")
	-- Detect the operating system
	local is_macos = os.getenv("OSTYPE") == "darwin"
	local is_linux = os.getenv("OSTYPE") == "linux-gnu"

	local cmd_or_ctrl = is_macos and "CMD" or "CTRL"
	local act = wezterm.action

	local tmux_executable = "/opt/homebrew/bin/tmux" -- <--- IMPORTANT: REPLACE THIS PATH
	-- if is_macos then
	config.keys = {
		{
			key = "Delete",
			mods = "NONE",
			action = wezterm.action.SendString("\x1b[3~"),
		},
		{
			key = "Escape",
			mods = "NONE",
			action = wezterm.action.SendString("\x1b[27u"),
		},
		-- -- Shortcut for starting a new workspace
		-- -- Disable the default CMD+f action to allow CMD+f to be used in neovim for searching
		-- { key = "f", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
		-- {
		-- 	key = "T",
		-- 	mods = "CMD|SHIFT",
		-- 	action = wezterm.action.SwitchToWorkspace,
		-- },
		-- -- Shortcut for listing and switching workspaces
		-- {
		-- 	key = "L",
		-- 	mods = "CMD|SHIFT",
		-- 	action = wezterm.action.SendString("\x1b[99;5u"), -- Custom escape sequence
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
		{
			key = "\\",
			mods = "CMD|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Use CMD + SHIFT + - to split horizontally
		{ key = "-", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- Cycle to the next pane
		{ key = "[", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
		-- -- Cycle to the previous pane
		{ key = "]", mods = "CMD", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
		-- Open Wezterm's config with Cmd + ,
		{
			key = ",",
			mods = "CTRL",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.config_file },
			}),
		},
		-- -- Switch to copy mode with Cmd + X
		-- {
		-- 	key = "X",
		-- 	mods = "CMD",
		-- 	action = wezterm.action.ActivateCopyMode,
		-- },

		-- -- Enable using Cmd + {a,s,f,p} with tmux
		-- {
		-- 	key = "a",
		-- 	mods = "CMD",
		-- 	action = wezterm.action.SendString("\x1ba"),
		-- },
		-- {
		-- 	key = "s",
		-- 	mods = "CMD",
		-- 	action = wezterm.action.SendString("\x1bs"),
		-- },
		-- {
		--   key = "p",
		--   mods = "CMD",
		--   action = wezterm.action.SendString("\x1bp"),
		-- },
		{
			key = "f",
			mods = "CMD",
			action = wezterm.action.SendString("\x1bf"),
		},
		-- {
		--   key = "F",
		--   mods = "CMD",
		--   action = wezterm.action.SendString("\x1bF"),
		-- }

		-- -- Map Cmd+t to create a new tmux window
		-- -- Rule 1: Explicitly disable the default action. This is processed first.
		-- {
		-- 	key = "t",
		-- 	mods = "CMD",
		-- 	action = act.DisableDefaultAssignment,
		-- },

		-- -- Rule 2: Attach our simplified callback. This is processed second.
		-- {
		-- 	key = "t",
		-- 	mods = "CMD",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		-- Attempt 1: Get CWD from the active pane
		-- 		local cwd_object = pane:get_current_working_dir()
		-- 		if cwd_object then
		-- 			-- THIS IS THE FIX: Access .path directly from the object
		-- 			local cwd = cwd_object.path
		-- 			wezterm.run_child_process({ tmux_executable, "new-window", "-c", cwd })
		-- 			return
		-- 		end

		-- 		-- Attempt 2: Fallback to HOME env var
		-- 		local home = os.getenv("HOME")
		-- 		if home then
		-- 			wezterm.run_child_process({ tmux_executable, "new-window", "-c", home })
		-- 			return
		-- 		end
		-- 	end),
		-- },

		-- -- Other mappings (Cmd+w, etc.) are fine as they are
		-- {
		-- 	key = "w",
		-- 	mods = "CMD",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		window:perform_action(act.DisableDefaultAssignment, pane)
		-- 		wezterm.run_child_process({ tmux_executable, "kill-pane" })
		-- 	end),
		-- },
		-- {
		-- 	key = "]",
		-- 	mods = "CMD",
		-- 	action = act.DisableDefaultAssignment,
		-- },
		-- -- Rule 2: Attach our external command callback.
		-- {
		-- 	key = "]",
		-- 	mods = "CMD",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		wezterm.run_child_process({ tmux_executable, "next-window" })
		-- 	end),
		-- },

		-- -- To map Cmd + Shift + [ (which is Cmd + {) for PREVIOUS window
		-- -- Rule 1: Explicitly disable the default action.
		-- {
		-- 	key = "[",
		-- 	mods = "CMD",
		-- 	action = act.DisableDefaultAssignment,
		-- },
		-- -- Rule 2: Attach our external command callback.
		-- {
		-- 	key = "[",
		-- 	mods = "CMD",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		wezterm.run_child_process({ tmux_executable, "previous-window" })
		-- 	end),
		-- },
		-- {
		-- 	key = "}",
		-- 	mods = "CMD",
		-- 	action = wezterm.action.SendKey { key = "F13", mods = "CTRL|SHIFT" },
		-- },

		-- -- Step 2: Bind our desired tmux action to the non-conflicting proxy key.
		-- {
		-- 	key = "F13",
		-- 	mods = "CTRL|SHIFT",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		wezterm.run_child_process({ tmux_executable, "next-window" })
		-- 	end),
		-- },
		-- -- Rule 1: Disable any potential default action.
		-- {
		-- 	key = "_",
		-- 	mods = "CMD",
		-- 	action = act.DisableDefaultAssignment,
		-- },
		-- -- Rule 2: Attach our external command callback.
		-- {
		-- 	key = "_",
		-- 	mods = "CMD",
		-- 	action = wezterm.action_callback(function(window, pane)
		-- 		local cwd_object = pane:get_current_working_dir()
		-- 		if cwd_object then
		-- 			local cwd = cwd_object.path
		-- 			wezterm.run_child_process({ tmux_executable, "split-window", "-h", "-c", cwd })
		-- 		else
		-- 			-- Fallback if CWD fails
		-- 			wezterm.run_child_process({ tmux_executable, "split-window", "-h" })
		-- 		end
		-- 	end),
		-- },
	}
	-- end

	-- if is_linux then
	-- 	config.keys = {
	-- 		-- Shortcut for starting a new workspace
	-- 		{
	-- 			key = "T",
	-- 			mods = "CTRL|SHIFT",
	-- 			action = wezterm.action.SwitchToWorkspace,
	-- 		},
	-- 		-- Shortcut for listing and switching workspaces
	-- 		{
	-- 			key = "L",
	-- 			mods = "CTRL|SHIFT",
	-- 			action = wezterm.action.ShowLauncherArgs({
	-- 				flags = "WORKSPACES",
	-- 			}),
	-- 		},
	-- 		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	-- 		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- 		-- Make Option-Right equivalent to Alt-f; forward-word
	-- 		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- 		-- Make Cmd-Left move to the start of the line
	-- 		{ key = "LeftArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bOH" }) },
	-- 		-- Make Cmd-Right move to the ending of the line
	-- 		{ key = "RightArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bOF" }) },
	-- 		-- Don't confirm upon closing tab
	-- 		{ key = "w", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- 		-- Use CMD + SHIFT + \ to split horizontally
	-- 		{
	-- 			key = "\\",
	-- 			mods = "CTRL|SHIFT",
	-- 			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- 		},
	-- 		-- Use CMD + SHIFT + - to split horizontally
	-- 		{ key = "-", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- 		-- Cycle to the next pane
	-- 		{ key = "[", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
	-- 		-- Cycle to the previous pane
	-- 		{ key = "]", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },

	-- 		{ key = "]", mods = "ALT|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	-- 		{ key = "[", mods = "ALT|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	-- 		-- Open Wezterm's config with Cmd + ,
	-- 		{
	-- 			key = ",",
	-- 			mods = "ALT",
	-- 			action = wezterm.action.SpawnCommandInNewTab({
	-- 				cwd = wezterm.home_dir,
	-- 				args = { "nvim", wezterm.config_file },
	-- 			}),
	-- 		},
	-- 		-- Switch to copy mode with Cmd + X
	-- 		{
	-- 			key = "X",
	-- 			mods = "ALT",
	-- 			action = wezterm.action.ActivateCopyMode,
	-- 		},
	-- 	}
	-- end
end
