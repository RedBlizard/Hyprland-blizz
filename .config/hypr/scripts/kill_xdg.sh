#!/bin/bash
# __  ______   ____
# \ \/ /  _ \ / ___|
#  \  /| | | | |  _
#  /  \| |_| | |_| |
# /_/\_\____/ \____|
#

export XDG_CURRENT_DESKTOP=Hyprland

# Setup Timers
sleep 1

# Kill all possible running xdg-desktop-portals (suppress errors if not running)
killall -e xdg-desktop-portal-hyprland 2>/dev/null
killall -e xdg-desktop-portal-gnome 2>/dev/null
killall -e xdg-desktop-portal-kde 2>/dev/null
killall -e xdg-desktop-portal-lxqt 2>/dev/null
killall -e xdg-desktop-portal-wlr 2>/dev/null
killall -e xdg-desktop-portal-gtk 2>/dev/null
killall -e xdg-desktop-portal 2>/dev/null

# Stop all services
systemctl --user stop xdg-desktop-portal 2>/dev/null
systemctl --user stop xdg-desktop-portal-gnome 2>/dev/null
systemctl --user stop xdg-desktop-portal-kde 2>/dev/null
systemctl --user stop xdg-desktop-portal-wlr 2>/dev/null
systemctl --user stop xdg-desktop-portal-hyprland 2>/dev/null

# Reset failed states (prevents systemd from refusing to start them again)
systemctl --user reset-failed xdg-desktop-portal* 2>/dev/null





