#!/bin/bash

# Function to check for updates and generate notification if updates are available
check_updates() {
    # Change to the dotfiles directory
    cd "$HOME/Hyprland-blizz" || { echo "Failed to change to dotfiles directory." >&2; exit 1; }

    # Fetch the latest changes from the remote repository
    git fetch origin main

    # Compare the local branch with the remote repository
    local commits_behind=$(git rev-list --count HEAD..origin/main)
    if [ "$commits_behind" -gt 0 ]; then
        # Updates are available
        send_notification "Updates are available for the dotfiles. Run the welcome app now!!!" "critical"
        return 0
    else
        # No updates available
        return 1
    fi
}

# Function to send a notification using notify-send (compatible with swaync)
send_notification() {
    local message="$1"
    local urgency="$2"
    notify-send --urgency="$urgency" "$message"
}

# Initial notification loop after boot/reboot
for (( i=1; i<=1; i++ )); do
    if check_updates; then
        send_notification "Updates are available for the dotfiles. Please update." "normal"
        # Wait for 10 seconds
        sleep 10
    else
        # No updates available, wait for 10 seconds
        sleep 10
    fi
done

# Initial notification loop
for (( i=1; i<=2; i++ )); do
    if check_updates; then
        send_notification "Updates are available for the dotfiles. PLease update." "normal"
        # Wait for 5 minutes
        sleep 300        
    else
        # No updates available, wait for 5 minutes
        sleep 300
    fi
done

# Regular notification loop
while true; do
    if check_updates; then
        send_notification "Updates are available for the dotfiles. Please update." "normal"
        # Wait for 15 minutes
        sleep 900
    else
        # No updates available, wait for 15 minutes
        sleep 900
    fi
done
