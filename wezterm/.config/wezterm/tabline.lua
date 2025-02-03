return function(config)
	local wezterm = require("wezterm")
	local nord = require("nord")
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			icons_enabled = false,
			theme = "nord", -- tabline theme
			icons_only = true,
			color_overrides = {
				tab = {
					active = { fg = nord.bg, bg = nord.glacier },
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
