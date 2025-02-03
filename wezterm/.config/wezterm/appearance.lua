return function(config)
	local wezterm = require("wezterm")
	-- Load nord colors to manually modify some stuff
	local nord = require("nord")
	-- Set the color scheme
	local scheme = "nord"
	config.color_scheme = scheme

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
		{ source = { Color = "#282c35" }, width = "100%", height = "100%", opacity = 0.99 },
	}
	-- Monospace tab bar font
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = false

	-- Set initial columns and rows to large values
	config.initial_cols = 128
	config.initial_rows = 38

	-- Position tab bar at the bottom instead of top
	config.tab_bar_at_bottom = false

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
