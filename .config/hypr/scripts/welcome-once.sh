#!/bin/bash

sleep 5

# Function to launch the welcome app at mouse pointer position
launch_welcome_app() {
    # Get current mouse position
    mouse_pos=$(xdotool getmouselocation --shell)
    mouse_x=$(echo "$mouse_pos" | grep "X=" | cut -d "=" -f 2)
    mouse_y=$(echo "$mouse_pos" | grep "Y=" | cut -d "=" -f 2)
    
    echo "Launching welcome app at mouse pointer position: $mouse_x, $mouse_y"

    # Define paths
    logo_path="$HOME/.config/hypr/imgs/yad_settings.png"
    settings_script="$HOME/.config/hypr/scripts/yad_settings.sh"
    update_mirrors_script="$HOME/.config/hypr/scripts/reflector_simple.sh"
    eos_rankmirrors_script="$HOME/.config/hypr/scripts/eos-rankmirrors.sh"
    cleanup_script="$HOME/.config/hypr/scripts/cleanup.sh"
    kitty_script="$HOME/.config/hypr/scripts/yad_update_dots.sh"
    waybar_script="$HOME/.config/waybar/scripts/yad_baraction.sh"

    # Show main menu
    yad --title="Settings" --image="$logo_path" --image-on-top \
        --form --no-buttons --on-top --undecorated \
        --field="Wiki Hyprland":FBTN "xdg-open 'https://wiki.hyprland.org/'" \
        --field="Waybar Wiki":FBTN "xdg-open 'https://github.com/Alexays/Waybar/wiki'" \
        --field="Discovery":FBTN "xdg-open 'https://discovery.endeavouros.com/'" \
        --field="Arch Wiki":FBTN "xdg-open 'https://wiki.archlinux.org/'" \
        --field="Update mirrors":FBTN "bash $update_mirrors_script" \
        --field="Rank mirrors":FBTN "bash $eos_rankmirrors_script" \
        --field="Endeavouros":FBTN "xdg-open 'https://endeavouros.com/'" \
        --field="Forum":FBTN "xdg-open 'https://forum.endeavouros.com/'" \
        --field="Update hyprland":FBTN "bash $kitty_script" \
        --field="Set your waybar":FBTN "bash $waybar_script" \
        --field="Settings":FBTN "bash $settings_script" \
        --field="Maintenance":FBTN "bash $cleanup_script" \
        --width=800 --height=360 --button-layout=spread --columns=3 --posx="$mouse_x" --posy="$mouse_y" &

    
    # Define the flag file path for one-time execution
    ONCE_FLAG_FILE="$HOME/.config/hypr/scripts/exec_once_flag"

    echo "Checking if the flag file exists: $ONCE_FLAG_FILE"

    # Check if the flag file exists
    if [ ! -e "$ONCE_FLAG_FILE" ]; then
        echo "Flag file not found. Running one-time execution tasks..."
        
        # Create flag file to mark one-time execution
        touch "$ONCE_FLAG_FILE"
        
        echo "Flag file created: $ONCE_FLAG_FILE"
    else
        echo "Flag file found. Scripts have already been executed. Exiting."
        exit
    fi
    
    # Get the PID of the Yad process
    yad_pid=$!

    # Trap the escape key combination to prevent closing the dialog
    trap 'echo "Escape key combination detected. Dialog cannot be closed."' SIGINT

    # Wait for the Yad process to finish
    wait $yad_pid


# Call the function to launch the welcome app at mouse pointer position
launch_welcome_app
