#!/bin/bash

remove_debug_packages() {
    debug_packages=$(pacman -Qq | grep '\-debug$')

    if [ -z "$debug_packages" ]; then
        echo "No debug packages found."
        return 0
    fi

    echo "Removing debug packages:"
    echo "$debug_packages"

    # safer loop (handles spaces + avoids word splitting issues)
    echo "$debug_packages" | while read -r package; do
        sudo pacman -Rs --noconfirm "$package"
    done

    echo "Debug packages removed successfully."
}

remove_debug_packages
