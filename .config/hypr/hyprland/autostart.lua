hl.on("hyprland.start", function()
	-- Display wallpaper
	hl.exec_cmd("systemctl --user start hyprpaper.service")
	-- Notification daemon
	hl.exec_cmd("app2unit -- swaync")
	-- GUI authentication agent
	hl.exec_cmd("systemctl --user start hyperpolkitagent.service")
	-- Waybar
	hl.exec_cmd("systemctl --user start waybar.service")
	-- Update DBus env vars so xdg-desktop-portal-hyprland can get the
	-- required variables on startup
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- Automatic mounting
	hl.exec_cmd("app2unit -- udiskie")
	-- Restart desktop portals (must be done after updating DBus env vars)
	hl.exec_cmd("restart-hyprland-desktop-portals")
end)
