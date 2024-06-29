#!/bin/bash

# Store audio device information in a temporary file
audio_info_file=$(mktemp)
{
    echo "Sinks:"
    pactl list sinks
    echo
    echo "Sources:"
    pactl list sources
} > "$audio_info_file"

# Display the information using yad in a text-info dialog
yad --title="Audio Device Information" \
    --text-info \
    --filename="$audio_info_file" \
    --width=900 \
    --height=410 \
    --button="   You can just close me...:0"

# Remove the temporary file
rm "$audio_info_file"
