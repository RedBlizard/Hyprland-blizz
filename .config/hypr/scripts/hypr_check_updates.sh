#!/bin/bash

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
        local formatted_message="Update reminder!
There are updates available.        
Please run the hypr-welcome app and update."
    else
        # Default to just using the provided message for other urgency levels
        local formatted_message="$message"
    fi

    notify-send --urgency="$urgency" "$formatted_message"
}

# Function to check for updates in all repositories
check_updates() {
    local repos=("Hyprland-blizz" "hypr-welcome" "hypr-waybar")
    local update_needed=1

    cd "$HOME/hyprland-dots" || { echo "Failed to change to hyprland-dots directory." >&2; exit 1; }

    for repo in "${repos[@]}"; do
        cd "$repo" || { echo "Failed to change to $repo directory." >&2; continue; }
        git fetch origin main
        local commits_behind=$(git rev-list --count HEAD..origin/main)
        if [ "$commits_behind" -gt 0 ]; then
            update_needed=0
            break
        fi
        cd ..
    done

    return $update_needed
}

# Initial critical notifications
for (( i=1; i<=2; i++ )); do
    if check_updates; then
        send_notification "Updates are available. Run the hypr-welcome app now!!!" "critical"
    fi
    # Wait for 1 minute
    sleep 180
done

# Additional critical notification after 5 minutes
sleep 300
if check_updates; then
    send_notification "Updates are available. Run the hypr-welcome app now!!!" "critical"
fi

# Regular notification loop with normal priority, only if critical notifications were ignored
sleep 900  # First reminder after 15 minutes
while true; do
    if check_updates; then
        send_notification "Updates are available. Run the hypr-welcome app." "normal"
    fi
    # Subsequent reminders every 30 minutes
    sleep 1800
done
