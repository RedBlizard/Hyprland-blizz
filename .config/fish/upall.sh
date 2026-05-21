#!/bin/sh
#source https://github.com/x70b1/polybar-scripts

check_updates() {
    if command -v checkupdates &>/dev/null; then
        checkupdates
    elif command -v yay &>/dev/null; then
        yay -Qua --noconfirm
    fi
}

install_updates() {
    if command -v yay &>/dev/null; then
        yay -Syu --noconfirm
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu --noconfirm
    fi
}

updates=$(check_updates)
if [ -n "$updates" ]; then
    echo "$updates"
    echo "Downloading and installing updates..."
    install_updates
else
    echo "No updates available."
fi
