return function(config)
	local wezterm = require("wezterm")

	-- Define or require your nord color palette
	-- Using placeholder values for this example
	local nord = require("nord")

	-- This is the key setting to remove "1:", "2:", etc., from tab titles.
	config.show_tab_index_in_tab_bar = false

	-- Set your desired window opacity. The status bar will match this.
	-- The value can be from 0.0 (fully transparent) to 1.0 (fully opaque).
	-- config.window_background_opacity = 0.85

	config.colors = {
		-- This makes the background of the tab bar area transparent.
		tab_bar = {
			background = "transparent",
			active_tab = {
				bg_color = "transparent",
				fg_color = nord.yellow,
			},
			-- Make inactive tabs blend into the transparent bar
			inactive_tab = {
				bg_color = "transparent",
				fg_color = nord.gray,
			},
			inactive_tab_hover = {
				bg_color = "transparent",
				fg_color = nord.darkest_white,
			},
			new_tab = {
				bg_color = nord.black,
				fg_color = nord.darkest_white,
			},
		},
	}

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local number = tostring(tab.tab_index + 1)

		-- If it's the last tab, just return the number.
		-- For all other tabs, return the number followed by a separator.
		if tab.tab_index == #tabs - 1 then
			return number
		else
			return number .. "  "
		end
	end)

	wezterm.on("update-status", function(gui_window, pane)
		local tabs = gui_window:mux_window():tabs()
		local mid_width = 0
		for idx, tab in ipairs(tabs) do
			local title = tab:get_title()
			mid_width = mid_width + math.floor(math.log(idx, 10)) + 1
			mid_width = mid_width + 2 + #title + 1
		end
		local tab_width = gui_window:active_tab():get_size().cols
		local max_left = tab_width / 2 - mid_width / 2 - 8

		gui_window:set_left_status(wezterm.pad_left(" ", max_left))
		gui_window:set_right_status("")
	end)

	-- Your original config was returned from a function, so we maintain that structure.
	return config
end -- return function(config)
-- 	local wezterm = require("wezterm")
-- 	local nord = require("nord")
-- 	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
-- 	-- Increase tab bar width
-- 	config.tab_max_width = 32
-- 	-- Set colors
-- 	local scheme_def = wezterm.color.get_builtin_schemes()["nord"]
-- 	config.colors = {
-- 		tab_bar = {
-- 			background = nord.black,
-- 			new_tab = {
-- 				bg_color = nord.black,
-- 				fg_color = scheme_def.foreground,
-- 			},
-- 			active_tab = {
-- 				bg_color = nord.gray,
-- 				fg_color = nord.darkest_white,
-- 			},
-- 			inactive_tab = {
-- 				bg_color = nord.black,
-- 				fg_color = nord.darkest_white,
-- 			},
-- 			inactive_tab_hover = {
-- 				bg_color = nord.glacier,
-- 				fg_color = "#000000",
-- 			},
-- 		},
-- 	}
-- 	tabline.setup({
-- 		options = {
-- 			icons_enabled = true,
-- 			theme = "nord", -- tabline theme
-- 			icons_only = true,
-- 			tab = {
-- 				color_overrides = {
-- 					active = { fg = nord.bg, bg = nord.dark_gray },
-- 					inactive = { fg = nord.white, bg = nord.black },
-- 					inactive_hover = { fg = nord.bg, bg = nord.pink },
-- 				},
-- 			},
-- 			section_separators = {
-- 				left = wezterm.nerdfonts.ple_right_half_circle_thick,
-- 				right = wezterm.nerdfonts.ple_left_half_circle_thick,
-- 			},
-- 			component_separators = {
-- 				left = wezterm.nerdfonts.ple_right_half_circle_thin,
-- 				right = wezterm.nerdfonts.ple_left_half_circle_thin,
-- 			},
-- 			tab_separators = {
-- 				left = wezterm.nerdfonts.ple_right_half_circle_thick,
-- 				right = wezterm.nerdfonts.ple_left_half_circle_thick,
-- 			},
-- 		},
-- 		sections = {
-- 			tabline_a = {},
-- 			tabline_b = {},
-- 			-- tabline_b = { "workspace" },
-- 			tabline_c = { " " },
-- 			tab_active = {
-- 				"index",
-- 				{ "process", padding = { left = 1, right = 0 } },
-- 				" ",
-- 				-- { "parent", padding = 0 },
-- 				-- "/",
-- 				{ "cwd", padding = { left = 0, right = 1 } },
-- 				-- { "]", padding = { left = 1, right = 1 } },
-- 			},
-- 			tab_inactive = {
-- 				"index",
-- 				{ "process", padding = { left = 1, right = 0 } },
-- 				" ",
-- 				-- { "parent", padding = 0 },
-- 				-- "/",
-- 				{ "cwd", padding = { left = 0, right = 1 } },
-- 			},
-- 			tabline_x = {},
-- 			tabline_y = {},
-- 			tabline_z = {},
-- 		},
-- 	})
-- end
