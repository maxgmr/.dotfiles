hl.config({
	input = {
		kb_layout = "us,us",
		kb_variant = "altgr-intl,rus",
		kb_options = "grp:win_space_toggle",

		repeat_delay = 250,

		sensitivity = 0.1,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
