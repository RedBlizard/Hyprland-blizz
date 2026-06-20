#!/bin/bash
# ----------------------------
# ROOT KVANTUM THEME SETTER
# Sets the Kvantum theme for the root user.
# Pure helper tool with NO flag logic or chmod side-effects.
# ----------------------------

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

ROOT_HOME="/root"
THEME_NAME="Catppuccin-Frappe-Red"

if [ ! -d "$ROOT_HOME/.Kvantum-themes/$THEME_NAME" ]; then
    echo "Error: Theme '$THEME_NAME' not found in $ROOT_HOME/.Kvantum-themes/" >&2
    exit 1
fi

echo "Setting Kvantum theme for root to $THEME_NAME..."
mkdir -p "$ROOT_HOME/.config/Kvantum"
cp -R "$ROOT_HOME/.Kvantum-themes/$THEME_NAME" "$ROOT_HOME/.config/Kvantum/"
sed -i "s/^Theme=.*/Theme=$THEME_NAME/" "$ROOT_HOME/.config/Kvantum/kvantum.kvconfig"
echo "Root Kvantum theme set successfully."
exit 0
