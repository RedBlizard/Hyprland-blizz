#!/bin/bash

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
            pacman -Rs --noconfirm "$package"
        done
        
        echo "Debug packages removed successfully."
    else
        echo "No debug packages found."
    fi
}

# Call the function to remove debug packages
remove_debug_packages
