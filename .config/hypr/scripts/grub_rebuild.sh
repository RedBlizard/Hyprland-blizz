#!/bin/bash

# Define path to the Grub rebuild script
grub_rebuild_script="$HOME/.config/hypr/scripts/grub_rebuild.sh"  # Replace with actual path to your Grub rebuild script

# Function to show the Grub rebuild dialog
show_grub_rebuild_dialog() {
    yad --title="Rebuild Grub" \
        --image="dialog-information" \
        --text="Click 'Rebuild Grub' to rebuild the bootloader configuration." \
        --button="Rebuild Grub:0" \
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
        0) # Rebuild Grub button pressed
            bash "$grub_rebuild_script"  # Replace with actual command to rebuild Grub
            ;;
        1) # Cancel button pressed or timeout reached
            echo "Grub rebuild canceled or timed out."
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
show_grub_rebuild_dialog

# Trap to clean up zombie processes
trap "sleep 0.2 ; hypr-eos-kill-yad-zombies --silent" EXIT


exit 0
