#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr/conf"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
LOG_FILE="$HOME/.config/hypr/scripts/hypr-reload.log"

echo "Script started" >> "$LOG_FILE" 2>&1

# Find all .conf files in the config directory and include hyprland.conf
CONF_FILES=$(find "$CONFIG_DIR" -type f -name "*.conf")
ALL_FILES="$CONF_FILES $HYPRLAND_CONFIG"

# Log which files are being watched
echo "Watching: $ALL_FILES" >> "$LOG_FILE" 2>&1

while true; do
    # Suppress standard output of inotifywait
    inotifywait -e modify $ALL_FILES > /dev/null
    echo "Change detected! Attempting to reload Hyprland..." >> "$LOG_FILE" 2>&1
    /usr/bin/hyprctl reload >> "$LOG_FILE" 2>&1
done
