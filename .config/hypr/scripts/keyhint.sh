#!/bin/bash

# ==========================================
# Hyprland Keybinds Viewer
# ==========================================

# 1. Path to your key_binds.lua file
KEYBINDS_FILE="$HOME/.config/hypr/modules/key_binds.lua"

# 2. Configuration
TERMINAL="kitty" # Kitty handles PTY dimensions perfectly for pagers like bat
THEME="Catppuccin Frappe"

# Check if the keybinds file actually exists
if [ ! -f "$KEYBINDS_FILE" ]; then
    echo "Error: Could not find $KEYBINDS_FILE!"
    exit 1
fi

# 3. Start the terminal with the appropriate viewer
# We use 'bat' for syntax highlighting (colors) and scrolling.
# '--paging=always' keeps the terminal open until you press 'q'.
# '--style=numbers' removes the grid borders so text uses the full width.
if command -v bat &> /dev/null; then
    $TERMINAL --title "Hyprland Keybinds" -e bash -c 'bat --theme="'"$THEME"'" --style=numbers --paging=always --color=always "'"$KEYBINDS_FILE"'"'
elif command -v batcat &> /dev/null; then
    # On some distros (like Ubuntu/Debian) the package is named 'batcat'
    $TERMINAL --title "Hyprland Keybinds" -e bash -c 'batcat --theme="'"$THEME"'" --style=numbers --paging=always --color=always "'"$KEYBINDS_FILE"'"'
else
    # Fallback: raw text with 'less' for scrolling if 'bat' is not installed
    $TERMINAL --title "Hyprland Keybinds" -e sh -c "cat '$KEYBINDS_FILE' | less -R"
fi

# ==========================================
# 5. Relaunch the welcome app
# ==========================================
# Once the terminal is closed, the script continues to this line and relaunches the welcome app.
bash "$HOME/.config/hypr-welcome/scripts/hypr-welcome"
