-- █▀▄▀█ Keybinds - Clean & Optimized
-- This configuration is structured for readability and maintainability

---- KEYBINDINGS ----
-- Translated from key_binds.conf
local mainMod = "SUPER"

---- Terminal / Apps (Workspace-based) ----
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("brave --app=https://www.youtube.com/"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/dolphin-as_root.sh"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("geany"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("kitty --class=nvim nvim"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/vscode.sh"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("brave --app=https://outlook.com"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/launch_helium-browser.sh"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("kitty --class=virt-manager virt-manager"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("waytrogen"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("guvcview"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("kitty --class=pacseek pacseek"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("nwg-look"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hypr-welcome"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("GParted"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("btrfs-assistant-launcher"))

---- Kitty Terminal Modes ----
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --title kitty_floats"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/kitty_fullscreen"))
hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/spawn-terminal.sh"))

---- Launchers ----
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/wofi-drun"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/wofi-run"))

---- Clipboard & Radio ----
hl.bind(mainMod .. " + ALT + H", hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/cliphist-menu.sh"))
hl.bind("CTRL + B", hl.dsp.exec_cmd("$HOME/.config/wofi/wofi-beats/wofi-beats -theme ~/.config/wofi/style.css"))

---- Network & Tools ----
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("$HOME/.config/hypr/hypr-network-manager/hypr-network-manager.sh"))

---- HyprPicker & Settings ----
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a -n")) -- Color picker
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("$HOME/.config/waybar/scripts/settings.sh"))

---- Waybar Scripts ----
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("$HOME/.config/waybar/scripts/toggle-waybar.sh"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("$HOME/.config/waybar/scripts/switch-waybar-config.sh"))

---- Keyhint & HyprIdle ----
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/keyhint.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("$HOME/.config/waybar/scripts/hypridle-toggle.sh"))

---- Wallpaper & KB Layout ----
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/changeWallpaper.sh"))
hl.bind("ALT + SHIFT_L", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/switch_kb_layout.sh"))

---- Lock & Logout ----
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("wlogout --protocol layer-shell -b 5 -T 400 -B 400"))

---- Screenshots ----
hl.bind("PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot rc"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot rf"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot ri"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot sc"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot sf"))
hl.bind("CTRL + SHIFT + PRINT", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/screenshot si"))

---- Audio / Microphone ----
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh volume_up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh volume_down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh volume_mute"))
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh mic_up"))
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh mic_down"))
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/volume.sh mic_mute"))

---- Media playback controls ----
hl.bind("XF86AudioPlay", function() user.audio.media_play() end,  { locked = true, desc = "Play/pause media" })
hl.bind("XF86AudioPause", function() user.audio.media_play() end, { locked = true, desc = "Play/pause media" })
hl.bind("XF86AudioNext",  function() user.audio.media_next() end, { locked = true, desc = "Next track" })
hl.bind("XF86AudioPrev",  function() user.audio.media_prev() end, { locked = true, desc = "Previous track" })
hl.bind("XF86AudioStop",  function() user.audio.media_stop() end, { locked = true, desc = "Stop media" })

---- Brightness ----
hl.bind("ALT + F12", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("ALT + F11", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

---- Game Mode & Settings ----
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/gamemode.sh"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/hyprmod.sh"))

---- Monitor Toggle ----
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/toggle_display.sh"))

---- General Float Toggle ----
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/toggle_float.sh"))

---- Debug Hyprland ----
hl.bind("CTRL + ALT + D", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/debug.sh"))
