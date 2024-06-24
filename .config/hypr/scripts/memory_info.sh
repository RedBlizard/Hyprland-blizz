#!/bin/bash

# Store memory information in a temporary file
memory_info_file=$(mktemp)
free -h > "$memory_info_file"

# Display the information using yad in a text-info dialog
yad --title="Memory Information" \
    --text-info \
    --filename="$memory_info_file" \
    --width=900 \
    --height=410 \
    --button="   You can just close me...:0"

# Remove the temporary file
rm "$memory_info_file"
