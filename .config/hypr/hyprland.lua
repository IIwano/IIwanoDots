------------------
---- MONITORS ----
------------------
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@74.97",
  position = "auto",
  scale = "auto",
})

require("colors")

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "rofi -show drun"
local mainMod = "SUPER"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("awww img ~/Pictures/wallpaper.jpg")
  hl.exec_cmd("mako")
  hl.exec_cmd("waybar > /tmp/waybar.log 2>&1")
  hl.exec_cmd("hypridle")
  hl.exec.cmd("cachy-update")
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

-----------------------------------
---- ENVIRONMENT VARIABLES ----
-----------------------------------
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 3,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    layout = "dwindle",
  },
  decoration = {
    rounding = 1,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    blur = { enabled = true, size = 4, passes = 2 },
  },
  animations = { enabled = true },
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
hl.window_rule({
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- pavucontrol flotante y centrado
hl.window_rule({
  name = "pavucontrol-float",
  match = { class = "org.pulseaudio.pavucontrol" },
  float = true,
  size = "500 400",
  center = true,
})

-- Diálogos de archivos (abrir/guardar) flotantes
hl.window_rule({
  name = "file-dialogs-float",
  match = { title = "Open File|Save File|Select file|Abrir archivo|Guardar archivo|Seleccionar archivo" },
  float = true,
  size = "800 550",
  center = true,
})

-- Picture-in-Picture de Brave: flotante, fijo encima, esquina inferior derecha
hl.window_rule({
  name = "brave-pip",
  match = { title = "Picture in picture|Picture-in-Picture" },
  float = true,
  pin = true,
  size = "420 260",
  move = "98%-w 98%-h",
})

-- Curvas de movimiento
hl.curve("smooth",    { type = "bezier", points = { {0.25, 0.10}, {0.25, 1.00} } })
hl.curve("soft",      { type = "bezier", points = { {0.40, 0.00}, {0.20, 1.00} } })
hl.curve("overshoot", { type = "bezier", points = { {0.34, 1.40}, {0.64, 1.00} } })

-- Animaciones
hl.animation({ leaf = "global",      enabled = true, speed = 6,  bezier = "smooth" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 7,  bezier = "overshoot", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 6,  bezier = "soft",      style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6,  bezier = "smooth" })
hl.animation({ leaf = "fade",        enabled = true, speed = 6,  bezier = "smooth" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "smooth" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 8,  bezier = "soft",      style = "slidefade 20%" })
hl.animation({ leaf = "layers",      enabled = true, speed = 6,  bezier = "smooth",    style = "fade" })

---------------
---- INPUT ----
---------------
hl.config({
  input = {
    kb_layout = "latam,us",
    kb_variant = ",",
    kb_options = "grp:alt_shift_toggle",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = { natural_scroll = true },
  },
})

hl.config({
  cursor = {
    hide_on_key_press = true,
    inactive_timeout = 5,
  },
  input = {
    follow_mouse = 1,
    mouse_refocus = true,
  },
})

---------------------
---- KEYBINDINGS ----
---------------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/pick-wallpaper.sh"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/random-wallpaper.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))

-- foco entre ventanas
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))

for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- mover/redimensionar con mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- clipboard con historial (cliphist + rofi)
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"))
