#!/bin/bash

# Function to launch kitty terminal
launch_kitty() {
    # Launch kitty terminal
    kitty bash -c "$1"
}

# Function to remove debug packages
remove_debug_packages() {
    # Get a list of debug packages
    debug_packages=$(pacman -Qq | grep '\-debug$')

    # Check if there are any debug packages installed
    if [ -n "$debug_packages" ]; then
        echo "Removing debug packages:"
        echo "$debug_packages"
        
        # Remove each debug package
        for package in $debug_packages; do
            sudo pacman -Rs "$package"
        done
        
        echo "Debug packages removed successfully."
    else
        echo "No debug packages found."
    fi
}

# Launch kitty terminal to clean Pacman cache, Yay cache, and remove debug packages
launch_kitty "sudo pacman -Scc && yay -Scc && $(declare -f remove_debug_packages); remove_debug_packages"

# Run the welcome script again
Sleep 2
bash $HOME/.config/hypr/scripts/yad_welcome.sh
