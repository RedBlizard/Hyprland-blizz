-- █▀▄▀█ Autostart - Hyprland 0.55+ Lua Native (Cleaned Up)
hl.on("hyprland.start", function()
    local home = os.getenv("HOME")
    
    -- ═══════════════════════════════════════
    -- DBus & Environment (MUST be first)
    -- ═══════════════════════════════════════
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Audio (early, before XDG portals)
    hl.exec_cmd("systemctl --user start pipewire")
    hl.exec_cmd("systemctl --user start wireplumber")

    -- XDG Portals
    hl.exec_cmd(home .. "/.config/hypr/scripts/kill_xdg.sh")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal")   
    
    -- ═══════════════════════════════════════
    -- Startup Sequence (SEQUENTIAL!)
    -- Configurator MUST finish before monitors.sh reads the generated files
    -- welcome.sh handles hypr-welcome internally via flags (no double call!)
    -- ═══════════════════════════════════════
    hl.exec_cmd(string.format(
        "sh -c '%s/.config/hypr/scripts/monitor_workspaces_configurator.sh && %s/.config/hypr/scripts/monitors.sh'",
        home, home
    ))
    
    hl.exec_cmd(home .. "/.config/hypr/scripts/disable-eos-welcome.sh")    
    hl.exec_cmd(home .. "/.config/hypr/scripts/random-wallpaper.sh")
    
    -- Only call welcome.sh - it manages hypr-welcome + waybar + flags internally
    hl.exec_cmd(home .. "/.config/hypr-welcome/scripts/welcome.sh")    
    
    hl.exec_cmd(home .. "/.config/hypr-welcome/scripts/hypr_check_updates.sh")
             
    -- ═══════════════════════════════════════
    -- UI & Async Scripts (safe to run parallel)
    -- ═══════════════════════════════════════
    hl.exec_cmd(home .. "/.config/waybar/scripts/update_waybar_network-device.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/watch-hyprland-config.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/restart-hyprland-config.sh")    
    hl.exec_cmd(home .. "/.config/hypr/scripts/chmod_scripts.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/nvidia_gpu_check.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/kvm-qemu.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/unlock-pacman.sh")
    hl.exec_cmd(home .. "/.config/waybar/scripts/hypridle-toggle.sh")
    hl.exec_cmd(home .. "/.config/waybar/scripts/firewall-applet.sh")

    -- ═══════════════════════════════════════
    -- Services & Security
    -- ═══════════════════════════════════════
    hl.exec_cmd("swaync")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("udev-block-notify")
    hl.exec_cmd("hypridle")
    
    -- Cursor & Keyboard
    hl.exec_cmd("hyprctl setcursor Qogir-white-cursors 24")
    hl.exec_cmd("sh -c 'echo us > /tmp/kb_layout'")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
