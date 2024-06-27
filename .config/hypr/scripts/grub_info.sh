#!/bin/bash

# Store GRUB information in a temporary file
grub_info_file=$(mktemp)

# Retrieve GRUB version and configuration
{
    echo "GRUB Version:"
    grub-install --version | head -n 1
    echo
    echo "GRUB Configuration (/boot/grub/grub.cfg):"
    cat /boot/grub/grub.cfg
    echo
    echo "Installed Kernels:"
    dpkg --list | grep linux-image | awk '{print $2, $3}'
    echo
    echo "GRUB Boot Entries:"
    grep menuentry /boot/grub/grub.cfg | cut -d "'" -f2
} > "$grub_info_file"

# Display the information using yad in a text-info dialog
yad --title="GRUB Information" \
    --text-info \
    --filename="$grub_info_file" \
    --width=900 \
    --height=410 \
    --button="   You can just close me...:0"

# Remove the temporary file
rm "$grub_info_file"
