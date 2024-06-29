#!/bin/bash

# Define path to the Grub update script
grub_update_script="$HOME/.config/hypr/scripts/grub_update.sh"  # Adjust path as per your actual script location

# Function to show the Grub update dialog
show_grub_update_dialog() {
    yad --title="Update Grub" \
        --image="dialog-information" \
        --text="Click 'Update Grub' to update the bootloader." \
        --button="Update Grub:0" \
        --button="   Back to main menu:1" \
        --on-top \
        --center \
        --width=900 \
        --height=410 \
        --fixed \
        --undecorated \
        --skip-taskbar \
        --timeout=10 \
        --timeout-indicator=top \
        --timeout-action=1 \
        --borders=3 \
        --text-align=center \
        --no-markup
        
    # Check the exit code to determine user action
    case $? in
        0) # Update Grub button pressed
            bash "$grub_update_script"  # Replace with actual command to update Grub
            ;;
        1) # Cancel button pressed or timeout reached
            echo "Grub update canceled or timed out."
            ;;
        252) # Timeout reached
            echo "Dialog closed automatically due to timeout."
            ;;
        *) # Other exit codes (if any)
            echo "Unexpected exit code $?."
            ;;
    esac
}

# Call function to show the dialog
show_grub_update_dialog

# Trap to clean up zombie processes
trap "sleep 0.2 ; hypr-eos-kill-yad-zombies --silent" EXIT

exit 0
