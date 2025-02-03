-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- The configuration is is grouped into categories separated into separate files
require("appearance")(config)
require("technical")(config)
require("keymaps")(config)
require("tabline")(config)
require("misc")(config)

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

return config
