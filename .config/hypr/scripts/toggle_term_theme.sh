#!/bin/bash

# Set the paths to your Kitty, Alacritty, and Fastfetch configuration files
kitty_custom_theme=~/.config/kitty/colorschemes/hyprland_redblizard_colorscheme.conf
kitty_endeavouros_theme=~/.config/kitty/colorschemes/endeavouros_colorscheme.conf

alacritty_custom_theme=~/.config/alacritty/hyprland-blizz-toml/alacritty.toml
alacritty_endeavouros_theme=~/.config/alacritty/Endeavouros-toml/alacritty.toml

fastfetch_custom_theme=~/.config/fastfetch/hyprland-blizz/config.jsonc
fastfetch_endeavouros_theme=~/.config/fastfetch/Endeavouros/config.jsonc

# Function to switch themes
switch_theme() {
    local source=$1
    local destination=$2
    local application=$3

    ln -sf "$source" "$destination"
    if [ $? -eq 0 ]; then
        echo "Switched to $application theme"
    else
        echo "Failed to switch to $application theme"
        exit 1
    fi
}

# Check if the desired theme is already active for Kitty
kitty_active_theme=$(readlink ~/.config/kitty/theme.conf)
if [[ $kitty_active_theme == *endeavouros_colorscheme* ]]; then
    switch_theme "$kitty_custom_theme" ~/.config/kitty/theme.conf "Kitty"
else
    switch_theme "$kitty_endeavouros_theme" ~/.config/kitty/theme.conf "Kitty"
fi

# Check if the desired theme is already active for Alacritty
alacritty_active_theme=$(readlink ~/.alacritty.yml)
if [[ $alacritty_active_theme == *Endeavouros-toml* ]]; then
    switch_theme "$alacritty_custom_theme" ~/.alacritty.yml "Alacritty"
else
    switch_theme "$alacritty_endeavouros_theme" ~/.alacritty.yml "Alacritty"
fi

# Check if the desired theme is already active for Fastfetch
fastfetch_active_theme=$(readlink ~/.config/fastfetch/config.jsonc)
if [[ $fastfetch_active_theme == *Endeavouros* ]]; then
    switch_theme "$fastfetch_custom_theme" ~/.config/fastfetch/config.jsonc "Fastfetch"
else
    switch_theme "$fastfetch_endeavouros_theme" ~/.config/fastfetch/config.jsonc "Fastfetch"
fi
