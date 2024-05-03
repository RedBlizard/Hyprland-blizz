#!/bin/bash

sleep 5

launch_welcome_app() {
    mouse_pos=$(xdotool getmouselocation --shell)
    mouse_x=$(echo "$mouse_pos" | grep "X=" | cut -d "=" -f 2)
    mouse_y=$(echo "$mouse_pos" | grep "Y=" | cut -d "=" -f 2)
    
    # Define paths
    logo_path="$HOME/.config/hypr/imgs/yad_settings.png"
    settings_script="$HOME/.config/hypr/scripts/yad_settings.sh"
    update_mirrors_script="$HOME/.config/hypr/scripts/reflector_simple.sh"
    eos_rankmirrors_script="$HOME/.config/hypr/scripts/eos-rankmirrors.sh"
    cleanup_script="$HOME/.config/hypr/scripts/cleanup.sh"
    kitty_script="$HOME/.config/hypr/scripts/yad_update_dots.sh"
    waybar_script="$HOME/.config/waybar/scripts/yad_baraction.sh"

    # Browser script path
    browser_script="$HOME/.config/hypr/scripts/welcome_browser.sh"

    ONCE_FLAG_FILE="$HOME/.config/hypr/scripts/exec-once-flag"

    # Check if the flag file exists
    if [ ! -e "$ONCE_FLAG_FILE" ]; then
        # Create flag file to mark one-time execution
        touch "$ONCE_FLAG_FILE"
    else
        exit
    fi
    
    yad --title="Settings" --image="$logo_path" --image-on-top \
        --form --no-buttons --on-top --undecorated \
        --field="Wiki Hyprland:FBTN" "$browser_script 'https://wiki.hyprland.org/'" \
        --field="Waybar Wiki:FBTN" "$browser_script 'https://github.com/Alexays/Waybar/wiki'" \
        --field="Discovery:FBTN" "$browser_script 'https://discovery.endeavouros.com/'" \
        --field="Arch Wiki:FBTN" "$browser_script 'https://wiki.archlinux.org/'" \
        --field="Update mirrors:FBTN" "bash $update_mirrors_script" \
        --field="Rank mirrors:FBTN" "bash $eos_rankmirrors_script" \
        --field="Endeavouros:FBTN" "$browser_script 'https://endeavouros.com/'" \
        --field="Forum:FBTN" "$browser_script 'https://forum.endeavouros.com/'" \
        --field="Update hyprland:FBTN" "bash $kitty_script" \
        --field="Set your waybar:FBTN" "bash $waybar_script" \
        --field="Settings:FBTN" "bash $settings_script" \
        --field="Maintenance:FBTN" "bash $cleanup_script" \
        --width=800 --height=360 --button-layout=spread --columns=3 --posx="$mouse_x" --posy="$mouse_y" &

    sleep 0.5

    pkill -f yad

    sleep 1
    bash "$HOME/.config/hypr/scripts/hypr-welcome"
}

launch_welcome_app
