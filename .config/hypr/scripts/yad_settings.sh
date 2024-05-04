#!/bin/bash

# Path to your custom logo or image
logo_path="$HOME/.config/hypr/imgs/yad_settings.png"

# Function to show the main menu
show_main_menu() {
    while true; do
        main_menu="Hyprland\nWaybar configs\nWaybar styles\nSwww options"
        selected_config=$(echo -e "$main_menu" | yad --title="Settings" --text="" --width=600 --height=300 --list --column="Settings" --separator='\n' --borders=9 -timeout=5 --button=exit --center --image="$logo_path")

        # Check if the escape button was pressed or the dialog was closed
        if [ "$selected_config" == "" ]; then
            echo "Escape key pressed or dialog closed. Exiting script."
            exit
        fi

        echo "Selected: $selected_config"

        case $selected_config in
            "Hyprland")
                launch_hyprland_settings ;;
            "Waybar configs")
                launch_waybar_configs ;;
            "Waybar styles")
                launch_waybar_styles ;;
            "Swww options")
                launch_swww_options ;;
            *)
                ;;
        esac
    done
}

# Function to launch Hyprland settings submenu
launch_hyprland_settings() {
    while true; do
        submenu="Back to main menu\n~/.config/hypr/hyprland.conf\n~/.config/hypr/conf/exec_once.conf\n~/.config/hypr/conf/env_var.conf\n~/.config/hypr/conf/monitor.conf\n~/.config/hypr/conf/workspaces.conf\n~/.config/hypr/conf/key_binds.conf\n~/.config/hypr/conf/window_binds.conf\n~/.config/hypr/conf/window_rules.conf"
        selected_submenu=$(echo -e "$submenu" | yad --title="Hyprland Settings" --text="" --width=600 --height=300 --list --column="Settings" --separator='\n' --borders=9 -timeout=5 --button=exit --center --image="$logo_path") 
        
        # Check if the escape button was pressed or the dialog was closed
        if [ "$selected_submenu" == "" ]; then
            echo "Escape key pressed or dialog closed. Exiting script."
            exit
        fi

        case $selected_submenu in
            "Back to main menu")
                break ;;
            *)
                echo "Launching nano for $selected_submenu"
                kitty nano "$selected_submenu" ;;
        esac
    done
}

# Function to launch Waybar configs submenu
launch_waybar_configs() {
    while true; do
        submenu="Back to main menu\n~/.config/waybar/conf/w1-config-desktop.jsonc\n~/.config/waybar/conf/w2-config-laptop.jsonc"
        selected_submenu=$(echo -e "$submenu" | yad --title="Waybar Configs" --text="" --width=600 --height=300 --list --column="Configs" --separator='\n' --borders=9 -timeout=5 --button=exit --center --image="$logo_path")
        
        # Check if the escape button was pressed or the dialog was closed
        if [ "$selected_submenu" == "" ]; then
            echo "Escape key pressed or dialog closed. Exiting script."
            exit
        fi

        case $selected_submenu in
            "Back to main menu")
                break ;;
            *)
                echo "Launching nano for $selected_submenu"
                kitty nano "$selected_submenu" ;;
        esac
    done
}

# Function to launch Waybar styles submenu
launch_waybar_styles() {
    while true; do
        submenu="Back to main menu\n~/.config/waybar/style/w1-style.css\n~/.config/waybar/style/w2-style.css"
        selected_submenu=$(echo -e "$submenu" | yad --title="Waybar Styles" --text="" --width=600 --height=300 --list --column="Styles" --separator='\n' --borders=9 -timeout=5 --button=exit --center --image="$logo_path")
        
        # Check if the escape button was pressed or the dialog was closed
        if [ "$selected_submenu" == "" ]; then
            echo "Escape key pressed or dialog closed. Exiting script."
            exit
        fi

        case $selected_submenu in
            "Back to main menu")
                break ;;
            *)
                echo "Launching nano for $selected_submenu"
                kitty nano "$selected_submenu" ;;
        esac
    done
}

# Function to launch Swww options submenu
launch_swww_options() {
    while true; do
        submenu="Back to main menu\nKill swww\nChange Wallpaper Directory\nInitialize swww"
        selected_submenu=$(echo -e "$submenu" | yad --title="Swww Options" --text="" --width=600 --height=300 --list --column="Options" --separator='\n' --borders=9 -timeout=5 --button=exit --center --image="$logo_path")
        
        # Check if the escape button was pressed or the dialog was closed
        if [ "$selected_submenu" == "" ]; then
            echo "Escape key pressed or dialog closed. Exiting script."
            exit
        fi

        case $selected_submenu in
            "Back to main menu")
                break ;;
            "Kill swww")
                echo "Killing swww"
                pkill swww ;;
            "Change Wallpaper Directory")
                echo "Launching nano for random-wallpaper"
                kitty nano ~/.config/hypr/scripts/random-wallpaper ;;
            "Initialize swww")
                echo "Initializing swww"
                swww init ;;
            *)
                ;;
        esac
    done
}

# Start the main menu loop
show_main_menu
