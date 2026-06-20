#!/bin/bash
# ----------------------------
# ROOT KVANTUM THEME HELPER
# Interactive helper tool to set the root Kvantum theme.
# Opens a kitty terminal to request sudo password and run the setter.
# This is a MANUAL helper tool, NOT an auto-start script.
# ----------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_THEME_SCRIPT="$SCRIPT_DIR/set_root_kvantum_theme.sh"

if [ ! -x "$ROOT_THEME_SCRIPT" ]; then
    echo "Error: $ROOT_THEME_SCRIPT not found or not executable." >&2
    exit 1
fi

kitty --title "Root Kvantum Theme Setter" bash -c "
    echo '=== Root Kvantum Theme Helper ==='
    echo 'Sets the Kvantum theme for the root user.'
    echo 'You will be prompted for your sudo password below.'
    echo ''
    sudo '$ROOT_THEME_SCRIPT'
    echo ''
    echo 'Press Enter to close this window...'
    read
"
