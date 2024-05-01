#!/bin/bash

# Define the directories
dir2="$HOME/.config/waybar/scripts"

# Function to chmod scripts in a directory
chmod_scripts() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Changing permissions for scripts in $dir"
        find "$dir" -type f -iname "*.sh" -exec chmod +x {} \;
        echo "Permissions changed successfully."
    else
        echo "Directory $dir does not exist."
    fi
}

# Create symlinks and run baraction.sh
create_symlinks_and_run_baraction() {
    # Define the paths for the desktop and laptop configurations
    DESKTOP_CONFIG_PATH=~/.config/waybar/conf/w1-config-desktop.jsonc
    LAPTOP_CONFIG_PATH=~/.config/waybar/conf/w2-config-laptop.jsonc

    # Define the paths for the desktop and laptop styles
    DESKTOP_STYLE_PATH=~/.config/waybar/style/w1-style.css
    LAPTOP_STYLE_PATH=~/.config/waybar/style/w2-style.css

    # Check the current Waybar configuration path
    CURRENT_CONFIG=$(readlink -f ~/.config/waybar/config.jsonc)

    # Check if the flag file exists
    FLAG_FILE="$HOME/.config/waybar/scripts/execution_flag"

    if [ ! -e "$FLAG_FILE" ]; then
        # Run scripts for the first time
        
        echo "Running scripts for the first time..."
        
        # Run chmod_scripts for directory with baraction.sh
        chmod_scripts "$dir2"
        
        # Check the current configuration and switch to the opposite
        if [ "$CURRENT_CONFIG" = "$DESKTOP_CONFIG_PATH" ]; then
            ln -sf "$LAPTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
            ln -sf "$LAPTOP_STYLE_PATH" ~/.config/waybar/style.css
        else
            ln -sf "$DESKTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
            ln -sf "$DESKTOP_STYLE_PATH" ~/.config/waybar/style.css
        fi
        
        # Create the flag file to prevent future runs
        touch "$FLAG_FILE"
    else
        echo "Scripts have already been executed. Exiting."
    fi
}

# Run the function to create symlinks and run baraction.sh
create_symlinks_and_run_baraction

# Define the flag file path
FLAG_FILE="$HOME/.config/waybar/scripts/execution_once_flag"

# Check if the flag file exists
if [ ! -e "$FLAG_FILE" ]; then
    # Terminate any existing Waybar instances
    pkill waybar
    # Wait for any existing Waybar instances to be terminated
    sleep 5

    # List of available Waybar configurations
    WAYBAR_CONFIGS=("Desktop" "Laptop")
    
    # Path to your custom logo or image
    logo_path="$HOME/.config/hypr/imgs/yad_settings.png"

    # Use yad to present the user with a menu
    selected_config=$(printf "%s\n" "${WAYBAR_CONFIGS[@]}" | yad --list --column="Configuration" --separator="" --no-headers --title="Choose Configuration" --text="" --center --width=200 --no-buttons --image="$logo_path")
    
# Check if the escape button was pressed or the dialog was closed
  if [ "$selected_config" == "" ]; then
       echo "Escape key pressed or dialog closed. Exiting script."
  exit
fi

    # Get the selected configuration
    selected_config=$(echo "$selected_config" | awk -F '|' '{print $1}')

    # Define the paths for the desktop and laptop configurations
    DESKTOP_CONFIG_PATH=~/.config/waybar/conf/w1-config-desktop.jsonc
    LAPTOP_CONFIG_PATH=~/.config/waybar/conf/w2-config-laptop.jsonc

    # Define the paths for the desktop and laptop styles
    DESKTOP_STYLE_PATH=~/.config/waybar/style/w1-style.css
    LAPTOP_STYLE_PATH=~/.config/waybar/style/w2-style.css

    # Update the Waybar configuration based on the user's selection
    case $selected_config in
      "Desktop")
        ln -sf "$DESKTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
        ln -sf "$DESKTOP_STYLE_PATH" ~/.config/waybar/style.css
        ;;
      "Laptop")
        ln -sf "$LAPTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
        ln -sf "$LAPTOP_STYLE_PATH" ~/.config/waybar/style.css
        ;;
      *)
        echo "Invalid selection."
        exit 1
        ;;
    esac

    # Run chmod_scripts for directory with baraction.sh
    chmod_scripts "$dir2"

    # Create flag file to mark execution
    touch "$FLAG_FILE"
fi

# Terminate already running bar instances
pkill waybar

# Wait until the Waybar processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch Waybar
waybar &
