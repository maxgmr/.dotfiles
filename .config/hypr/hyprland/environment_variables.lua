local options = require("hyprland/options")

hl.env("XCURSOR_SIZE", options.cursor_size)
hl.env("HYPRCURSOR_SIZE", options.cursor_size)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
