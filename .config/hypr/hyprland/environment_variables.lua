local options = require("hyprland/options")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("XCURSOR_SIZE", options.cursor_size)
hl.env("XCURSOR_THEME", options.cursor_theme)
-- hl.env("HYPRCURSOR_SIZE", options.cursor_size)
-- hl.env("HYPRCURSOR_THEME", options.cursor_theme)

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
