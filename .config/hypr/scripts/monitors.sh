#!/bin/bash
# monitors.sh - Dynamically toggle monitor rules in monitors.lua
# Replaces old .conf-based version. Works with Hyprland Lua config.
#
# Assumes all monitors are pre-defined in ~/.config/hypr/modules/monitors.lua
# Toggles them by uncommenting (-- hl.monitor → hl.monitor) or commenting out.

MONITOR_LUA="$HOME/.config/hypr/modules/monitors.lua"

if [ ! -f "$MONITOR_LUA" ]; then
    echo "Error: $MONITOR_LUA not found!" >&2
    exit 1
fi

handle() {
    case "$1" in
        monitoradded*)
            monitor=$(echo "$1" | cut -d' ' -f2)
            if [ "$monitor" = "HDMI-A-1" ]; then
                # Activate HDMI-A-1 rule (remove -- if present)
                sed -i -E "s|^-- *(hl\.monitor\(\{ output = \"HDMI-A-1\",)|\1|" "$MONITOR_LUA"
                hyprctl notify -1 2000 "rgb(00ff99)" "HDMI-A-1 connected"
            elif [ "$monitor" = "eDP-1" ]; then
                # Activate eDP-1 resolution rule (only the mode line, not disabled=true)
                sed -i -E "s|^-- *(hl\.monitor\(\{ output = \"eDP-1\",\s+mode = \"1920x1080\")|\1|" "$MONITOR_LUA"
                # Ensure disabled=true stays commented (we don't auto-disable laptop screen)
                sed -i -E "s|^(hl\.monitor\(\{ output = \"eDP-1\", disabled = true \}\))|-- \1|" "$MONITOR_LUA"
                hyprctl notify -1 2000 "rgb(00ff99)" "eDP-1 connected"
            fi
            ;;
            
        monitorremoved*)
            monitor=$(echo "$1" | cut -d' ' -f2)
            if [ "$monitor" = "HDMI-A-1" ]; then
                # Comment out HDMI-A-1 rule
                sed -i -E "s|^(hl\.monitor\(\{ output = \"HDMI-A-1\",)|-- \1|" "$MONITOR_LUA"
                hyprctl notify -1 2000 "rgb(ff9900)" "HDMI-A-1 disconnected"
            elif [ "$monitor" = "eDP-1" ]; then
                # Comment out eDP-1 resolution rule
                sed -i -E "s|^(hl\.monitor\(\{ output = \"eDP-1\",\s+mode = \"1920x1080\")|-- \1|" "$MONITOR_LUA"
                hyprctl notify -1 2000 "rgb(ff9900)" "eDP-1 disconnected"
            fi
            ;;
    esac
    
    # Apply changes immediately
    hyprctl reload
}

# Start listening to Hyprland events
socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle "$line"
done
