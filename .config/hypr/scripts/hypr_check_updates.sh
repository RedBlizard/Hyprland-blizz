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
        send_notification "Updates are available. Run the hypr-welcome app now!!!" "critical"
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

    if [ "$urgency" = "critical" ]; then
        # Format the message for critical notifications
        local formatted_message="Critical update!
There are updates available.
Run the hypr-welcome app and update."

    elif [ "$urgency" = "normal" ]; then
        # Format the message for normal notifications
        local formatted_message="Update reminder.
There are updates available.        
Please run the hypr-welcome app and update."

    else
        # Default to just using the provided message for other urgency levels
        local formatted_message="$message"
    fi

    notify-send --urgency="$urgency" "$formatted_message"
}

# Initial notification loop for critical updates
for (( i=1; i<=2; i++ )); do
    if check_updates; then
        send_notification "Updates are available. Run the hypr-welcome app now!!!" "critical"
    fi
    # Wait for 1 minute
    sleep 60
done

# Additional critical notification after 5 minutes
if check_updates; then
        send_notification "Updates are available. Run the hypr-welcome app now!!!" "critical"
fi
sleep 300

# Regular notification loop with normal priority
while true; do
    if check_updates; then
        send_notification "Updates are available. Run the hypr-welcome app." "normal"
    fi
    # First reminder after 15 minutes
    sleep 900

    # Subsequent reminders every 30 minutes
    while true; do
        if check_updates; then
             send_notification "Updates are available. Run the hypr-welcome app." "normal"
        fi
        sleep 1800
    done
done
