#!/bin/bash

# creates flag for the monitor_workspaces_configurator script

# Define the lock file
lock_file="$HOME/.config/hypr/scripts/monitor_workspaces_flag"

# Check if the lock file exists
if [ -e "$lock_file" ]; then
    echo "monitor_workspaces_configurator has already run. Exiting."
    exit 1
fi
# Your script's code goes here
echo "Starting monitor_workspaces_configurator script..."
# This is where you would put the actual commands you want your script to run
# Example:
# ./path/to/yad_switch-waybar-config.sh
$HOME/.config/hypr/scripts/monitor_workspaces_configurator.sh

# Create the lock file
echo "Creating flag file..."
touch "$lock_file"

echo "monitor_workspaces_configurator script completed successfully."

# creates flag for the yad_switch-waybar-config script

sleep 2

# Define the lock file
lock_file="$HOME/.config/waybar/scripts/waybar_flag"

# Check if the lock file exists
if [ -e "$lock_file" ]; then
    echo "yad_switch-waybar-config script has already run. Exiting."
    exit 1
fi
# Your script's code goes here
echo "Starting yad_switch-waybar-config script..."
# This is where you would put the actual commands you want your script to run
# Example:
# ./path/to/yad_switch-waybar-config.sh
$HOME/.config/waybar/scripts/yad_switch-waybar-config.sh

# Create the lock file
echo "Creating flag file..."
touch "$lock_file"

echo "yad_switch-waybar-config script completed successfully."

sleep 4

# creates flag for the hypr-welcome script

# Define the lock file
lock_file="$HOME/.config/hypr/scripts/welcome_flag"

# Check if the lock file exists
if [ -e "$lock_file" ]; then
    echo "Welcome script has already run. Exiting."
    exit 1
fi

# Your script's code goes here
echo "Starting hypr-welcome script..."
# This is where you would put the actual commands you want your script to run
# Example:
# ./path/to/hypr-welcome.sh
$HOME/.config/hypr/scripts/hypr-welcome

# Create the lock file
echo "Creating flag file..."
touch "$lock_file"

echo "Hypr-welcome script completed successfully."
