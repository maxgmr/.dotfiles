-- Ignore maximize requests from apps
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-wayland-drags",
    match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
    },
    no_focus = true,
})

-- Fix xwaylandvideobridge window not being hidden correctly:
-- https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/
hl.window_rule({
    name = "fix-xwaylandvideobridge-hiding",
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = "0.0 override",
    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = { 1, 1 },
})
