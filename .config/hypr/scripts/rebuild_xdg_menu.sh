#!/bin/bash

# Function to rebuild xdg menu
rebuild_xdg_menu() {
   XDG_MENU_PREFIX=arch- kbuildsycoca6

}

# Listen for package installation or removal events
sudo pacman -Syu --noconfirm >/dev/null 2>&1
sudo pacman -Qq >/dev/null 2>&1

# Rebuild xdg menu
rebuild_xdg_menu


