#!/bin/bash

# Store disk and USB device information in a temporary file
device_info_file=$(mktemp)
{
    echo "Disks:"
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
    echo
    echo "USB Devices:"
    lsusb
} > "$device_info_file"

# Display the information using yad in a text-info dialog
yad --title="Disk and USB Device Information" \
    --text-info \
    --filename="$device_info_file" \
    --width=900 \
    --height=410 \
    --button="   You can just close me...:0"

# Remove the temporary file
rm "$device_info_file"
