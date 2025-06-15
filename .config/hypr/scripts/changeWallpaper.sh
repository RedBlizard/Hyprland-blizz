#!/bin/bash

# Directory for wallpapers
DIR=$HOME/Pictures/wallpapers-redblizard/

# Initialize or check if swww is running
pgrep -x swww-daemon >/dev/null || (swww-daemon & disown)

if ! pgrep -x swww-daemon >/dev/null; then
  echo "Starting swww-daemon at $(date)" >> ~/.cache/swww/wall_loop.log
  swww-daemon & disown
fi

# Randomly select a wallpaper
PICS=($(find "${DIR}" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \)))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

# Change wallpaper using swww with transition effects
swww img "$RANDOMPICS" --transition-step 20 --transition-fps=20

# Copy the selected wallpaper to $HOME/.cache/swww as current_wallpaper.png
cp "${RANDOMPICS}" "$HOME/.cache/swww/current_wallpaper.png"


    # Generate color scheme with pywal (Uncomment the following line if needed)
    # wal -i "$RANDOMPICS"

    # Uncomment the following line if you use Firefox with pywalfox extension
    # pywalfox update

    # Optionally clear the swww cache (Uncomment the following line if needed)
    # rm -rf $HOME/.cache/swww


