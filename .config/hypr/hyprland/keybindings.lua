local options = require("hyprland/options")

local mainMod = "SUPER"

local codeEsc = "code:9"
local codeQ = "code:24"
local codeE = "code:26"
local codeR = "code:27"
local codeT = "code:28"
local codeO = "code:32"
local codeP = "code:33"
local codeEnter = "code:36"
local codeS = "code:39"
local codeD = "code:40"
local codeF = "code:41"
local codeH = "code:43"
local codeJ = "code:44"
local codeK = "code:45"
local codeL = "code:46"
local codeV = "code:55"
local codeN = "code:57"
local codeM = "code:58"

-- Close window
hl.bind(mainMod .. " + " .. codeQ, hl.dsp.window.close())
-- Kill window
hl.bind(mainMod .. " + SHIFT + " .. codeQ, hl.dsp.window.kill())
-- Shut down hyprland
hl.bind(mainMod .. " + SHIFT + " .. codeE, hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Toggle window states
hl.bind(mainMod .. " + " .. codeF, hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + " .. codeM, hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + " .. codeV, hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + " .. codeO, hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + " .. codeP, hl.dsp.window.pseudo({ action = "toggle" }))

-- App launchers
hl.bind(mainMod .. " + " .. codeEnter, hl.dsp.exec_cmd(options.terminal))
hl.bind(mainMod .. " + " .. codeD, hl.dsp.exec_cmd(options.menu))
hl.bind(mainMod .. " + " .. codeE, hl.dsp.exec_cmd(options.fileManager))
hl.bind(mainMod .. " + " .. codeT, hl.dsp.exec_cmd(options.browser))

-- Move focus
hl.bind(mainMod .. " + " .. codeH, hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. codeL, hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. codeK, hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. codeJ, hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + " .. codeH, hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + " .. codeL, hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + " .. codeK, hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + " .. codeJ, hl.dsp.window.move({ direction = "down" }))

-- Resize windows
hl.bind(mainMod .. " + " .. codeR, hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind(codeH, hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind(codeL, hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind(codeK, hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind(codeJ, hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind(codeEsc, hl.dsp.submap("reset"))
end)

-- Switch workspaces & move windows to workspace
for ws = 1, 10 do
    local key = ws % 10 -- Map workspace 10 to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Audio multimedia keys
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "SHIFT + XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "SHIFT + XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
    { locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- Adjust brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1%+"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { locked = true, repeating = true })

-- Take screenshot and edit
hl.bind(mainMod .. " + SHIFT + " .. codeS, hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
-- Take screenshot and save to file
hl.bind(
    mainMod .. " + SHIFT + " .. codeD,
    hl.dsp.exec_cmd('grim -g "$(slurp)" ' .. options.screenshot_dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png")
)

-- Open notifications
hl.bind(mainMod .. " + " .. codeN, hl.dsp.exec_cmd("swaync-client -t -sw"))
