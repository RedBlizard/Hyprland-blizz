#!/bin/bash

# Define the icons
icondisabled="<span font='10'>󰾪</span>"
iconenabled="<span font='10'>󰅶</span>"
fifo="/tmp/waybar_swayidle_fifo"

if pgrep -x "swayidle" > /dev/null; then
    # Caffeine is enabled, so disable it
    killall swayidle
    # Update the Waybar module to display the disabled coffee cup icon immediately
    echo '{"text": "'"$icondisabled"'"}' > "$fifo"
else
    # Caffeine is disabled, so enable it
    swayidle -w \
        before-sleep "hyprlock" \
        timeout 110 'temp=$(brightnessctl g); brightnessctl set $((temp / 2))' \
            resume 'temp=$(brightnessctl g); brightnessctl set $((temp * 2))' \
        timeout 120 "$HOME/.config/hypr/scripts/hyprlock_cmd" \
        timeout 140 "hyprctl dispatch dpms off && systemctl suspend" \
            resume 'hyprctl dispatch dpms on' &
    # Update the Waybar module to display the enabled coffee cup icon immediately
    echo '{"text": "'"$iconenabled"'"}' > "$fifo"
fi
