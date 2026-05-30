#!/bin/bash
# monitors.sh - Dynamically toggle monitor rules in monitors.lua
# Replaces old .conf-based version. Works with Hyprland Lua config.
#
# Assumes all monitors are pre-defined in ~/.config/hypr/modules/monitors.lua
# Toggles them by uncommenting (-- hl.monitor → hl.monitor) or commenting out.
# Uses hyprctl keyword for instant, flicker-free application.

MONITOR_LUA="$HOME/.config/hypr/modules/monitors.lua"
LOCKFILE="/tmp/hypr-monitors.lock"

if [ ! -f "$MONITOR_LUA" ]; then
    echo "Error: $MONITOR_LUA not found!" >&2
    exit 1
fi

# Prevent race conditions during rapid hotplug events
exec 200>"$LOCKFILE"
flock -n 200 || { echo "Another instance running, skipping."; exit 0; }

handle() {
    case "$1" in
        monitoradded*)
            monitor=$(echo "$1" | cut -d' ' -f2)
            if [ "$monitor" = "HDMI-A-1" ]; then
                # Activate HDMI-A-1 rule in Lua file (remove -- if present)
                sed -i -E "s|^-- *(hl\.monitor\(\{ output = \"HDMI-A-1\",)|\1|" "$MONITOR_LUA"
                # Apply instantly without full reload
                hyprctl keyword monitor "HDMI-A-1,1920x1080@50,1920x0,1"
                hyprctl notify -1 2000 "rgb(00ff99)" "HDMI-A-1 connected"
            elif [ "$monitor" = "eDP-1" ]; then
                # Activate eDP-1 resolution rule (only the mode line, not disabled=true)
                sed -i -E "s|^-- *(hl\.monitor\(\{ output = \"eDP-1\",\s+mode = \"1920x1080\")|\1|" "$MONITOR_LUA"
                # Ensure disabled=true stays commented
                sed -i -E "s|^(hl\.monitor\(\{ output = \"eDP-1\", disabled = true \}\))|-- \1|" "$MONITOR_LUA"
                # Apply instantly
                hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
                hyprctl notify -1 2000 "rgb(00ff99)" "eDP-1 connected"
            fi
            ;;
        monitorremoved*)
            monitor=$(echo "$1" | cut -d' ' -f2)
            if [ "$monitor" = "HDMI-A-1" ]; then
                # Comment out HDMI-A-1 rule in Lua file
                sed -i -E "s|^(hl\.monitor\(\{ output = \"HDMI-A-1\",)|-- \1|" "$MONITOR_LUA"
                # Disable instantly
                hyprctl keyword monitor "HDMI-A-1,disable"
                hyprctl notify -1 2000 "rgb(ff9900)" "HDMI-A-1 disconnected"
            elif [ "$monitor" = "eDP-1" ]; then
                # Comment out eDP-1 resolution rule
                sed -i -E "s|^(hl\.monitor\(\{ output = \"eDP-1\",\s+mode = \"1920x1080\")|-- \1|" "$MONITOR_LUA"
                # Note: We do NOT disable eDP-1 on removal, as it's the primary display
                hyprctl notify -1 2000 "rgb(ff9900)" "eDP-1 disconnected"
            fi
            ;;
    esac
}

# Start listening to Hyprland events
socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle "$line"
done
