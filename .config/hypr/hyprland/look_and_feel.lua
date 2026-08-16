local options = require("hyprland/options")

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 1,

		border_size = 2,

		col = {
			active_border = options.border_colour,
			inactive_border = "rgba(00000000)",
		},

		no_focus_fallback = true,
		resize_on_border = false,

		allow_tearing = false,

		layout = "dwindle",
	},
	decoration = {
		rounding = 1,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 0.9,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = false,
		},
		glow = {
			enabled = false,
		},
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		background_color = "rgba(282828ff)",

		font_family = "Serif",

		disable_autoreload = true,

		enable_swallow = true,
		swallow_regex = "^(Alacritty|kitty|footclient|foot)$",
	},
})

-- Smart gaps
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_out = 0,
	gaps_in = 0,
})
hl.workspace_rule({
	workspace = "w[f1]",
	gaps_out = 0,
	gaps_in = 0,
})
hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})
