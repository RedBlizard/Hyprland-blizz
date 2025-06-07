#!/bin/bash

# Terminate any existing swaybg processes if running
if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

# Initialize or check if swww is running
swww query || swww-daemon

# Set the directory where the backgrounds are stored
BACKGROUND_DIR="$HOME/Pictures/wallpapers-redblizard/"


# Define paths and scripts (adjust paths as per your setup)
logo_path="$HOME/.config/hypr/imgs/hypr-welcome.png"

# Get the list of backgrounds
BACKGROUND_LIST=("$BACKGROUND_DIR"/*)

# Prepare the background list for yad --list
backgrounds_string=$(printf "%s\n" "${BACKGROUND_LIST[@]}")

# Use Yad to display the list of backgrounds with a preview
selected_background=$(echo "$backgrounds_string" | yad --list --title="Select a Background" \
  --image="$logo_path" \
  --image-on-top-center \
  --borders=3 \
  --geometry=900x400+800+200 \
  --column="Backgrounds" --image-column="Preview:IMG" --separator=" " --height=400 --width=600 \
  --button=Cancel:1 --button=Apply:0 --item-icon "${BACKGROUND_LIST[@]}" --image-on-top)

# Capture the exit status of Yad
response=$?

# If the user clicks Cancel (exit status 1), exit the script
if [ $response -eq 1 ]; then
  exit 1
fi



# If no background is selected, exit
if [ -z "$selected_background" ]; then
  exit 1
fi


# Set the selected background
echo "$selected_background"

# DEBUG: print selected background
echo "Selected background: '$selected_background'"

# Copy selected wallpaper
cp $selected_background "$HOME/.cache/swww/current_wallpaper.png"

# Apply the selected background using swww
swww img $selected_background  --transition-step 20 --transition-fps 20

# Send a notification with the new background name and an icon from the current background
notify-send -i $selected_background "Background changed" "$(basename "$selected_background")"
