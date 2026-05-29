-- █▀▄▀█ Autostart - Hyprland 0.55+ Lua Native
-- Based on: https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    local home = os.getenv("HOME")
    
    -- Kill all possible running xdg-desktop-portals
    hl.exec_cmd(home .. "/.config/hypr/scripts/kill_xdg.sh")
    
    -- DBus & Environment
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- UI
    hl.exec_cmd("waybar")
    hl.exec_cmd(home .. "/.config/waybar/scripts/update_waybar_network-device.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/random-wallpaper.sh")
    
    -- XDG Portals
    hl.exec_cmd("systemctl --user start xdg-desktop-portal")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
        
    -- Scripts (async)
    hl.exec_cmd(home .. "/.config/hypr/scripts/watch-hyprland-config.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/restart-hyprland-config.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/disable-eos-welcome.sh")    
    hl.exec_cmd(home .. "/.config/hypr/scripts/monitors.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/monitor_workspaces_configurator.sh")
    hl.exec_cmd(home .. "/.config/hypr-welcome/scripts/hypr_check_updates.sh")
    hl.exec_cmd(home .. "/.config/hypr-welcome/scripts/welcome.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/chmod_scripts.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/nvidia_gpu_check.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/kvm-qemu.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/unlock-pacman.sh")
    hl.exec_cmd(home .. "/.config/waybar/scripts/hypridle-toggle.sh")
    hl.exec_cmd(home .. "/.config/waybar/scripts/firewall-applet.sh")

    -- Services
    hl.exec_cmd("systemctl --user start pipewire")
    hl.exec_cmd("systemctl --user start wireplumber")
    hl.exec_cmd("swaync")
    hl.exec_cmd("udiskie")

    -- Security & Idle
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("udev-block-notify")
    hl.exec_cmd("hypridle")
    
    -- Cursor
    hl.exec_cmd("hyprctl setcursor Qogir-white-cursors 24")
    
    -- Keyboard layout indicator (shell redirect needs sh -c)
    hl.exec_cmd("sh -c 'echo us > /tmp/kb_layout'")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

end)
