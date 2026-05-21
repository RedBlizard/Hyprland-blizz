#!/bin/bash
# __  ______   ____
# \ \/ /  _ \ / ___|
#  \  /| | | | |  _
#  /  \| |_| | |_| |
# /_/\_\____/ \____|
#

export XDG_CURRENT_DESKTOP=Hyprland

#!/bin/bash
sleep 1

# Kill ALL running portals
killall -q xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland

# Set required environment variables
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

sleep 1

# Start hyprland portal (only if not running already)
if ! pgrep -x "xdg-desktop-portal-hyprland" >/dev/null; then
  /usr/lib/xdg-desktop-portal-hyprland &
fi

sleep 2

# Start the main xdg-desktop-portal (only if not running already)
if ! pgrep -x "xdg-desktop-portal" >/dev/null; then
  /usr/lib/xdg-desktop-portal &
fi

# Restart audio services
systemctl --user restart pipewire wireplumber




