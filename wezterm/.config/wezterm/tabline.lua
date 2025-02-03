return function(config)
	local wezterm = require("wezterm")
	local nord = require("nord")
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	-- Increase tab bar width
	config.tab_max_width = 32
	-- Set colors
	local scheme_def = wezterm.color.get_builtin_schemes()["nord"]
	config.colors = {
		tab_bar = {
			background = nord.black,
			new_tab = {
				bg_color = nord.black,
				fg_color = scheme_def.foreground,
			},
			active_tab = {
				bg_color = nord.gray,
				fg_color = nord.darkest_white,
			},
			inactive_tab = {
				bg_color = nord.black,
				fg_color = nord.darkest_white,
			},
			inactive_tab_hover = {
				bg_color = nord.glacier,
				fg_color = "#000000",
			},
		},
	}
	tabline.setup({
		options = {
			icons_enabled = true,
			theme = "nord", -- tabline theme
			icons_only = true,
			tab = {
				color_overrides = {
					active = { fg = nord.bg, bg = nord.dark_gray },
					inactive = { fg = nord.white, bg = nord.black },
					inactive_hover = { fg = nord.bg, bg = nord.pink },
				},
			},
			section_separators = {
				left = wezterm.nerdfonts.ple_right_half_circle_thick,
				right = wezterm.nerdfonts.ple_left_half_circle_thick,
			},
			component_separators = {
				left = wezterm.nerdfonts.ple_right_half_circle_thin,
				right = wezterm.nerdfonts.ple_left_half_circle_thin,
			},
			tab_separators = {
				left = wezterm.nerdfonts.ple_right_half_circle_thick,
				right = wezterm.nerdfonts.ple_left_half_circle_thick,
			},
		},
		sections = {
			tabline_a = {},
			tabline_b = { "workspace" },
			tabline_c = { " " },
			tab_active = {
				"index",
				{ "process", padding = { left = 0, right = 0 } },
				" ",
				-- { "parent", padding = 0 },
				-- "/",
				{ "cwd", padding = { left = 0, right = 1 } },
				-- { "]", padding = { left = 1, right = 1 } },
			},
			tab_inactive = {
				"index",
				{ "process", padding = { left = 0, right = 0 } },
				" ",
				-- { "parent", padding = 0 },
				-- "/",
				{ "cwd", padding = { left = 0, right = 1 } },
			},
			tabline_x = {},
			tabline_y = {},
			tabline_z = { "hostname" },
		},
	})
end
