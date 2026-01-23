return function(config)
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
