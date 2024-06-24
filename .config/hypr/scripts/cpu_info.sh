#!/bin/bash

# Store CPU information in a temporary file
cpu_info_file=$(mktemp)
lscpu > "$cpu_info_file"

# Display the information using yad in a text-info dialog
yad --title="CPU Information" \
    --text-info \
    --filename="$cpu_info_file" \
    --width=900 \
    --height=410 \
    --button="   You can just close me...:0"

# Remove the temporary file
rm "$cpu_info_file"
