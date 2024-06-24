#!/bin/bash

# kill hypr-welcome
pkill -f yad

# Set default GTK theme
default_theme='Catppuccino-Frappe-Standard-Blue-Dark'
gsettings set org.gnome.desktop.interface gtk-theme "$default_theme"

# Run eos-rankmirrors
eos-log-tool

# Run the welcome script again after a short delay
sleep 2
bash $HOME/.config/hypr/scripts/hypr-welcome
