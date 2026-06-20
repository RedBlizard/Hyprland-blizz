# Hyprland LUA

My Hyprland dotfiles migrated to Lua for Hyprland 0.55+. Modular configuration, utility scripts, and everything I learned battling the API.

## Structure

```
~/.config/hypr/
├── hyprland.lua          # Entry point — just require() calls to modules
├── wallpaper.sh           # Sets wallpaper via hyprpaper
├── hotcorner.sh           # Hot corners: top corners trigger hyprexpo
├── modules/
│   ├── monitors.lua       # Monitors, resolutions, refresh rates
│   ├── env.lua            # Environment variables (Wayland, Qt, GTK, XDG)
│   ├── autostart.lua      # Apps launched on Hyprland start
│   ├── appearance.lua     # Borders, blur, shadows, rounded corners
│   ├── animations.lua     # Bezier curves and window animations
│   ├── input.lua          # Keyboard (latam), touchpad, repeat rate
│   ├── plugins.lua        # hyprexpo, borders-plus-plus, hyprbars, hyprfocus
│   ├── binds.lua          # Keybinds (~80 binds)
│   ├── rules.lua          # Window and layer rules
│   └── hooks.lua          # Manual hooks (auto-resize on float, etc.)
└── scripts/
    ├── minimize.sh        # Move active window → special:minimized
    ├── minimize-all.sh    # Minimize all windows in workspace
    ├── unminimize.sh      # Restore last minimized window
    ├── unminimize-all.sh  # Restore all minimized to active workspace
    ├── toggle-float.sh    # Toggle float with smart resize
    ├── bar-switch.sh      # Switch between waybar and ironbar
    ├── gtk.sh             # GTK theme (Catppuccin Mocha Blue)
    ├── install-updates.sh # Update packages (yay + flatpak)
    ├── inject-super-tab.py # Inject Super+Tab at kernel level (uinput)
    ├── hotcorner.sh       # Symlink to ~/.config/hypr/hotcorner.sh
    └── add-hyprbars-buttons.sh # Window buttons via hyprctl
```

## Requirements

- **Hyprland ≥ 0.55** (Lua API is only available from this version)
- **Arch Linux** (scripts assume `pacman`, `yay`, `flatpak`)
- `hyprpm` plugins:
  - `hyprexpo` — exposé-like workspace overview
  - `borders-plus-plus` — per-side rounded corners
  - `hyprbars` — title bars with window buttons
  - `hyprfocus` — focus animation between windows

### Packages expected by scripts and binds

| Package | Purpose |
|---------|---------|
| `kitty` | Default terminal |
| `nautilus` | File manager |
| `rofi-wayland` or `rofi-lbonn-wayland` | App launcher |
| `waybar` | Status bar |
| `hyprpaper` | Wallpaper daemon |
| `swaync` | Notification center |
| `hyprlock` | Screen locker |
| `wlogout` | Logout/power menu |
| `polkit-gnome` | Authentication agent |
| `eww` | Widgets and sidebar |
| `grim` + `slurp` + `wl-copy` + `satty` | Screenshots with annotations |
| `cliphist` + `wl-clipboard` | Clipboard history |
| `pavucontrol` | Volume control (PulseAudio/PipeWire) |
| `blueman-manager` | Bluetooth |
| `nm-connection-editor` | Network connections |

## Installation

```bash
git clone https://github.com/vicos93/HyprlandLUA.git
cp HyprlandLUA/hyprland.lua ~/.config/hypr/
cp -r HyprlandLUA/modules ~/.config/hypr/
cp -r HyprlandLUA/scripts ~/.config/hypr/
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/hypr/hotcorner.sh
chmod +x ~/.config/hypr/wallpaper.sh
```

**Important**: Check `modules/monitors.lua` and update monitor names to match yours (`hyprctl monitors`). Also check paths in `autostart.lua` and `binds.lua` — some use absolute paths to my `$HOME`.

## Modules in detail

### `monitors.lua`
Two monitors: DP-1 at 1440p@144Hz and HDMI-A-1 at 1080p@100Hz with offset. Uses `hl.monitor()` for each output.

### `env.lua`
Environment variables for Wayland (`XDG_CURRENT_DESKTOP`, `XDG_SESSION_TYPE`), Qt (`QT_QPA_PLATFORM`, `QT_STYLE_OVERRIDE`, `QUP_STYLE_OVERRIDE=kvantum`), GTK (`GTK_THEME`, `XDG_CURSOR_THEME`), and toolkits (`_JAVA_AWT_WM_NONREPARENTING`, `CLUTTER_BACKEND`, `SDL_VIDEODRIVER`). Bibata cursor at 24px.

### `autostart.lua`
Uses `hl.on("hyprland.start", ...)` to launch everything on startup: waybar, hyprpaper, swaync, polkit-gnome, eww (sidebar + top bar), GTK theme, wallpaper, hotcorner daemon, and Handy (voice assistant).

### `appearance.lua`
- **Dwindle** layout with `smart_resizing` and `force_split`
- Rounded borders (8px) with gradient `#cba6f7 → #62a0ea`, 2px thickness
- Window blur (6px, 2 passes, 0.9 vibrancy) + shadows
- Decorations with rounded corners via `borders-plus-plus`
- Layer rule for blur on `eww-sidebar`

### `animations.lua`
Three custom bezier curves: `bounce`, `linear` (extra args to work around a janky animation bug), and `overshot`. 13 animation rules covering windows, fade, workspace switches, special workspace, layers, and `borderangle`.

### `input.lua`
**Latam** keyboard layout (`es`), fast repeat rate (25ms delay, 600ms rate), touchpad with tap-to-click, natural scroll, and `dwindle:smart_resizing`. Follow mouse set to 0 (disabled — click-to-focus only).

### `plugins.lua`
Configures all 4 plugins inside `hl.on("config.reloaded", ...)` so they reapply on reload. Includes hyprbars buttons: close (red), fullscreen (yellow), minimize (green). `hyprfocus` with slide animation.

### `binds.lua`
~80 keybinds:
- `Super+Return` → kitty, `Super+E` → nautilus, `Super+Space` → rofi
- `Super+Q` / `Super+C` → close / kill window
- `Super+J/K/H/L` and arrow keys for navigation
- `Super+R` → inline resize mode (uses `exec_raw` instead of submap)
- `Super+F` → toggle fullscreen, `Super+Shift+F` → toggle float
- `Super+Tab` → hyprexpo, `Super+V` → cliphist
- `Super+L` → hyprlock, `Super+Shift+E` → wlogout
- `Print` → screenshot with grim+slurp+wl-copy+satty
- Media keys for volume and brightness
- `Super+Minus` → minimize, `Super+Shift+Minus` → restore

### `rules.lua`
- `suppress_maximize` on all windows to avoid bugs with apps that force maximize
- Float + center for: pavucontrol, nm-applet, blueman, vsfetch (700x700), webapps (1000x700), system tools
- Layer rule for blur on `eww-sidebar`

### `hooks.lua`
`window.update_rules` hook that detects when a window transitions from tiled to floating and automatically applies resize (900x600) + center, skipping windows that already have explicit float rules (pavucontrol, etc.).

## Scripts

### Minimize system
Minimize using `special:minimized` as a special workspace. `minimize.sh` moves the active window there, `unminimize.sh` restores it. `-all` variants operate on the entire workspace.

### `toggle-float.sh`
Toggles the active window's floating state. When transitioning to float, resizes to 900x600 and centers automatically.

### `hotcorner.sh`
Background daemon that polls cursor position (`hyprctl cursorpos`). When the cursor reaches the top-left or top-right corner, it triggers `hyprexpo:expo`. Monitor geometry is reloaded dynamically every 60 seconds to handle resolution changes.

### `inject-super-tab.py`
Creates a virtual device with `python-uinput` and writes `KEY_LEFTMETA` + `KEY_TAB` at the kernel level. This triggers hyprexpo even when Hyprland doesn't have keyboard focus. Requires `uinput` loaded and write permissions on `/dev/uinput`.

### `bar-switch.sh`
Kills waybar and launches ironbar (or vice versa). Useful for testing alternative bars without restarting Hyprland.

## Notes

- **Hot reload**: `hl.on("config.reloaded", ...)` works, but occasionally fails with plugins. If something is off after a reload, a full Hyprland restart fixes it.
- **`exec_raw` vs submaps**: Hyprland submaps for resize sometimes get stuck with plugins enabled. Using `exec_raw` to fire `hyprctl dispatch resizeactive` is more reliable.
- **Module order**: `monitors.lua` must load first so rules and binds apply on top of the correct display configuration.

## License

MIT — do whatever you want with this.
