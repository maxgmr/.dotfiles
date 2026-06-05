hl.on("hyprland.start", function()
    -- Wallpaper
    hl.exec_cmd("hyprpaper")
    -- PipeWire
    hl.exec_cmd("gentoo-pipewire-launcher restart")
    -- Notification daemon
    hl.exec_cmd("swaync")
    -- GUI authentication agent
    hl.exec_cmd("/usr/libexec/hyprpolkitagent")
    -- Status bar
    hl.exec_cmd("waybar")
    -- Update DBus env vars so xdg-desktop-portal-hyprland can get the
    -- required variables on startup
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- Restart desktop portals (must be done after updating DBus env vars)
    hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
end)
