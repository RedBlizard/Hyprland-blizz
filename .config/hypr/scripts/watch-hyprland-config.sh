#!/bin/bash

# Add a small delay to ensure the Hyprland environment is ready
sleep 3

CONFIG_DIR="$HOME/.config/hypr/conf"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
LOG_FILE="$HOME/.config/hypr/scripts/hypr-reload.log"

echo "Script started" >> "$LOG_FILE" 2>&1

# Dynamically fetch the HYPRLAND_INSTANCE_SIGNATURE
export HYPRLAND_INSTANCE_SIGNATURE=$(echo $HYPRLAND_INSTANCE_SIGNATURE)

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    echo "HYPRLAND_INSTANCE_SIGNATURE not set! Exiting..." >> "$LOG_FILE" 2>&1
    exit 1
fi

# Find all .conf files in the config directory and include hyprland.conf
CONF_FILES=$(find "$CONFIG_DIR" -type f -name "*.conf")
ALL_FILES="$CONF_FILES $HYPRLAND_CONFIG"

# Log which files are being watched
echo "Watching: $ALL_FILES" >> "$LOG_FILE" 2>&1

# Ensure the Hyprland socket exists before proceeding
SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket.sock"
if [ ! -S "$SOCKET_PATH" ]; then
    echo "Hyprland socket not found at $SOCKET_PATH. Exiting..." >> "$LOG_FILE" 2>&1
    exit 1
fi

while true; do
    # Monitor configuration files for changes
    inotifywait -e modify $ALL_FILES > /dev/null 2>&1
    echo "Change detected! Attempting to reload Hyprland..." >> "$LOG_FILE" 2>&1
    /usr/bin/hyprctl reload >> "$LOG_FILE" 2>&1
done
