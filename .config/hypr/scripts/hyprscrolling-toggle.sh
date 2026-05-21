#!/bin/bash
PLUGIN_PATH="$HOME/.local/share/hyprland/plugins/hyprscrolling.so"
TOGGLE_FILE="$HOME/.config/hypr/.scrolling-enabled"

if [ -f "$TOGGLE_FILE" ]; then
    # Currently enabled → disable
    rm -f "$TOGGLE_FILE"
    notify-send "ScrollIndicator" "Disabled" --icon=input-mouse
else
    # Currently disabled → enable
    touch "$TOGGLE_FILE"
    notify-send "ScrollIndicator" "Enabled" --icon=input-mouse
fi

# Reload Hyprland config
hyprctl reload
