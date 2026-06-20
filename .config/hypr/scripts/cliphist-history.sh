#!/bin/bash
# ~/.config/hypr/scripts/cliphist-copy.sh

# Wofi configuration and style paths
CONFIG="$HOME/.config/wofi/cliphist-launcher/config"
STYLE="$HOME/.config/wofi/cliphist-launcher/style.css"

# Define the wofi command with your custom styling
WOFI_CMD="wofi --show dmenu --conf $CONFIG --style $STYLE"

# List clipboard history, select an item, decode it, and copy to clipboard
SELECTED=$(cliphist list | $WOFI_CMD -p "Clipboard History:")

if [ -n "$SELECTED" ]; then
    echo "$SELECTED" | cliphist decode | wl-copy
    
    # Send a quick, subtle notification to confirm the action
    notify-send "Clipboard" "Item copied to clipboard" -t 1500
fi
