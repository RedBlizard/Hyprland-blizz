#!/bin/bash

# Set the default volume to 35%
pactl set-sink-volume @DEFAULT_AUDIO_SINK@ 35%

# Function to display volume change notification
show_volume_notification() {
    local icon=$1
    local volume_bar=$2
    local vol=$3
    dunstify -a "Volume" -h string:x-dunst-stack-tag:volume -i "$icon" -u low "$volume_bar : $vol%" &
}

# Function to display microphone volume change notification
show_mic_notification() {
    local icon=$1
    local volume_bar=$2
    local vol=$3
    dunstify -a "Microphone volume" -h string:x-dunst-stack-tag:mic -i "$icon" -u low "$volume_bar : $vol%" &
}

# Function for Volume Up Script
volume_up() {
    # Lock file
    local lockfile="/tmp/volume_lock"
    touch "$lockfile"
    
    # Define bar and space variables
    bar="█" # You can use any character you like to represent the volume level
    space="░" # You can use any character you like to represent the remaining space

    # Increase volume by 5%
    pactl set-sink-volume @DEFAULT_AUDIO_SINK@ +5%

    # Get volume level for the default audio sink
    vol=$(pamixer --get-volume)
    
    # Generate volume bar
    volume_bar=$(seq -s "$bar" 0 $(((vol - 1) / 5)) | sed 's/[0-9]//g')
    remaining_space=$(seq -s "$space" 0 $((20 - vol / 5)) | sed 's/[0-9]//g')

    # Display notification with volume level and icon for volume increase
    show_volume_notification "audio-volume-high" "$volume_bar" "$vol"

    # Remove lock file
    rm "$lockfile"
}

# Function for Volume Down Script
volume_down() {
    # Lock file
    local lockfile="/tmp/volume_lock"
    touch "$lockfile"
    
    # Define bar and space variables
    bar="█" # You can use any character you like to represent the volume level
    space="░" # You can use any character you like to represent the remaining space

    # Decrease volume by 5%
    pactl set-sink-volume @DEFAULT_AUDIO_SINK@ -5%

    # Get volume level for the default audio sink
    vol=$(pamixer --get-volume)
    
    # Generate volume bar
    volume_bar=$(seq -s "$bar" 0 $(((vol - 1) / 5)) | sed 's/[0-9]//g')
    remaining_space=$(seq -s "$space" 0 $((20 - vol / 5)) | sed 's/[0-9]//g')

    # Display notification with volume level and icon for volume decrease
    show_volume_notification "audio-volume-high" "$volume_bar" "$vol"

    # Remove lock file
    rm "$lockfile"
}

# Function for Volume Mute Script
volume_mute() {
    # Lock file
    local lockfile="/tmp/volume_lock"
    touch "$lockfile"

    # Find the active sink
    active_sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')

    # Get the current mute state of the active sink
    current_mute=$(pactl list sinks | grep -A 10 "Name: $active_sink" | grep "Mute" | awk '{print $2}')

    # Define default icon
    icon="audio-volume-high"

    # Toggle the mute state of the active sink
    if [ "$current_mute" == "yes" ]; then
        pactl set-sink-mute "$active_sink" 0  # Unmute
        echo "Unmuted $active_sink"
        message="Volume unmuted"
    else
        pactl set-sink-mute "$active_sink" 1  # Mute
        echo "Muted $active_sink"
        icon="audio-volume-muted-symbolic"
        message="Volume muted"
    fi

    # Display notification
    show_volume_notification "$icon" "" "$message"

    # Remove lock file
    rm "$lockfile"
}

# Function for Microphone Volume Increase Script
mic_volume_up() {
    # Lock file
    local lockfile="/tmp/mic_lock"
    touch "$lockfile"
    
    # Define bar and space variables
    bar="█" # You can use any character you like to represent the volume level
    space="░" # You can use any character you like to represent the remaining space

    # Increase microphone volume by 5%
    pactl set-source-volume @DEFAULT_SOURCE@ +5%

    # Get volume level for the default audio sink
    vol=$(pamixer --get-volume)
    
    # Generate volume bar
    volume_bar=$(seq -s "$bar" 0 $(((vol - 1) / 5)) | sed 's/[0-9]//g')
    remaining_space=$(seq -s "$space" 0 $((20 - vol / 5)) | sed 's/[0-9]//g')

    # Display notification with volume level and icon for microphone volume increase
    show_mic_notification "microphone-sensitivity-high" "$volume_bar" "$vol"

    # Remove lock file
    rm "$lockfile"
}

# Function for Microphone Volume Decrease Script
mic_volume_down() {
    # Lock file
    local lockfile="/tmp/mic_lock"
    touch "$lockfile"
    
    # Define bar and space variables
    bar="█" # You can use any character you like to represent the volume level
    space="░" # You can use any character you like to represent the remaining space

    # Decrease microphone volume by 5%
    pactl set-source-volume @DEFAULT_SOURCE@ -5%

    # Get volume level for the default audio sink
    vol=$(pamixer --get-volume)
    
    # Generate volume bar
    volume_bar=$(seq -s "$bar" 0 $(((vol - 1) / 5)) | sed 's/[0-9]//g')
    remaining_space=$(seq -s "$space" 0 $((20 - vol / 5)) | sed 's/[0-9]//g')

    # Display notification with volume level and icon for microphone volume decrease
    show_mic_notification "microphone-sensitivity-high" "$volume_bar" "$vol"

    # Remove lock file
    rm "$lockfile"
}

# Function for Microphone Mute Script
mic_mute() {
    # Lock file
    local lockfile="/tmp/mic_lock"
    touch "$lockfile"

    # Find the active source (microphone)
    active_source=$(pactl info | grep 'Default Source' | awk '{print $3}')

    # Get the current mute state of the active source (microphone)
    current_mute=$(pactl list sources | grep -A 10 "Name: $active_source" | grep "Mute" | awk '{print $2}')

    # Define default icon
    icon=""

    # Toggle the mute state of the active source (microphone)
    if [ "$current_mute" == "yes" ]; then
        pactl set-source-mute "$active_source" 0  # Unmute
        echo "Microphone unmuted: $active_source"
        icon="microphone-sensitivity-high"  # Unmuted icon
        message="Microphone unmuted"
    else
        pactl set-source-mute "$active_source" 1  # Mute
        echo "Microphone muted: $active_source"
        icon="microphone-sensitivity-muted"  # Muted icon
        message="Microphone muted"
    fi

    # Display notification
    show_mic_notification "$icon" "" "$message"

    # Remove lock file
    rm "$lockfile"
}

# Main script starts here
echo "Starting Volume Script"

# Check which action to perform
if [[ $1 == "volume_up" ]]; then
    volume_up
elif [[ $1 == "volume_down" ]]; then
    volume_down
elif [[ $1 == "volume_mute" ]]; then
    volume_mute
elif [[ $1 == "mic_up" ]]; then
    mic_volume_up
elif [[ $1 == "mic_down" ]]; then
    mic_volume_down
elif [[ $1 == "mic_mute" ]]; then
    mic_mute
fi

echo "Volume Script Finished"
