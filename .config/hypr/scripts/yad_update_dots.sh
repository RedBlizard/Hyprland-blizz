#!/bin/bash

# Function to launch a Kitty terminal
launch_kitty() {
    # Check if the current terminal is Kitty
    if [ -z "$KITTY_WINDOW_ID" ]; then
        if ! kitty -e "$0" &>/dev/null; then
            echo "Failed to launch Kitty. Please check your Kitty installation or configuration."
            exit 1
        fi
        exit
    fi
}

# Launch Kitty
launch_kitty

# Set the log file path
log_file="$HOME/dotfiles-update_log.txt"

# Redirect stdout (1) and stderr (2) to the log file
exec > >(tee -i "$log_file") 2>&1

# Making a backup of main configs in .config

# Get the current username
username=$(whoami)

echo "Now we are making a backup of existing configurations!"
echo

# Create a backup directory if it doesn't exist
backup_dir="/home/$username/.config/backup"
mkdir -p "$backup_dir"

# Function to backup a directory
backup() {
    local source_dir="$1"
    local dest_dir="$2"
    
    # Create the destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    
    # Copy the contents of the source directory to the destination directory
    cp -r "$source_dir" "$dest_dir"
}

# List of folders to backup
folders=("alacritty" "btop" "cava" "dunst" "hypr" "kitty" "Kvantum" "networkmanager-dmenu" "nwg-look" "pacseek" "pipewire" "qt6ct" "ranger" "sddm-config-editor" "Thunar" "waybar" "wlogout" "wofi" "xsettingsd" "gtk-2.0" "gtk-3.0" "gtk-4.0" "starship")

# Backup and copy each folder
for folder in "${folders[@]}"; do
    folder_path="/home/$username/.config/$folder"
    backup_path="$backup_dir/$folder"
    
    # Check if the folder exists
    if [ -d "$folder_path" ]; then
        # Backup the folder
        backup "$folder_path" "$backup_path"
    else
        # Create the folder and then backup
        mkdir -p "$folder_path"
        backup "$folder_path" "$backup_path"
    fi
done

# Ensure the script is in the correct directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR" || { echo 'Failed to change directory to script directory.'; exit 1; }

RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${RED}░█─░█ █──█ █▀▀█ █▀▀█ █── █▀▀█ █▀▀▄ █▀▀▄ 　 █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀ 　 █──█ █▀▀█ █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀${NC}" 
echo -e "${RED}░█▀▀█ █▄▄█ █──█ █▄▄▀ █── █▄▄█ █──█ █──█ 　 █──█ █──█ ──█── ▀▀█ 　 █──█ █──█ █──█ █▄▄█ ──█── █▀▀${NC}" 
echo -e "${RED}░█─░█ ▄▄▄█ █▀▀▀ ▀─▀▀ ▀▀▀ ▀──▀ ▀──▀ ▀▀▀─ 　 ▀▀▀─ ▀▀▀▀ ──▀── ▀▀▀ 　 ─▀▀▀ █▀▀▀ ▀▀▀─ ▀──▀ ──▀── ▀▀▀${NC}"
# Add two empty rows
echo
NC='\033[0m' # No Color

BLUE='\033[0;38;5;38m'
NC='\033[0m' # No Color
# Getting in the dotfiles

echo -e "${BLUE}Now we are getting in the dotfiles. Please be patient, this might take a while.${NC}"
echo
# Clone the dotfiles repository, overwriting if it already exists
echo "Cloning dotfiles repository..."
#!/bin/bash

# Function to show a message with color
show_message() {
    local message="$1"
    local color="$2"
    echo -e "${color}${message}${NC}"
}

# Define colors
BLUE='\033[1;34m'
NC='\033[0m' # No Color

show_message "Now we are getting in the dotfiles. Please be patient, this might take a while." "$BLUE"
echo

# Check if the dotfiles directory exists
if [ ! -d "$HOME/Hyprland-blizz" ]; then
    # Clone the dotfiles repository
    show_message "Cloning dotfiles repository..." "$BLUE"
    git clone "https://github.com/RedBlizard/Hyprland-blizz.git" "$DOTFILES_DIR" || { show_message "Failed to clone dotfiles repository." "$RED"; exit 1; }
else
    # Pull the latest changes from the dotfiles repository
    show_message "Pulling the latest changes from the dotfiles repository..." "$BLUE"
    # Change to the dotfiles directory
    cd "$HOME/Hyprland-blizz" || { show_message "Failed to change to dotfiles directory." "$RED"; exit 1; }
    git pull origin main || { show_message "Failed to pull dotfiles repository." "$RED"; exit 1; }
fi

# Get the commit hash before and after the pull
current_commit=$(git rev-parse HEAD)
new_commit=$(git rev-parse HEAD@{1})

# Check if there are updates
if [ "$current_commit" != "$new_commit" ]; then
    # Updates found, execute the rest of the code
    show_message "Checking for updates..." "$BLUE"
    if yay -Q xdg-desktop-portal-hyprland hyprland waybar &>/dev/null; then
        show_message "Hyprland, desktop portal, and Waybar have been updated." "$BLUE"
        # Show a notification for the update
        notify-send "Hyprland update available" "There is an update available for Hyprland. Please run the update script."
    else
        show_message "No updates found for Hyprland, desktop portal, and Waybar." "$BLUE"
    fi
else
    # No updates found for dotfiles
    show_message "No updates found for dotfiles." "$BLUE"
    # Notify the user about no dotfiles updates
    notify-send "No dotfile updates found you are fully up to date."
    # Stop the script here if there are no updates
fi

# Ask the user if they want to update dotfiles
read -rp "Do you want to update your dotfiles? (Enter 'Yy' for yes or 'Nn' for no): (Yy/Nn): " update_choice

if [ "$update_choice" == "y" ] || [ "$update_choice" == "Y" ]; then
    # Copy dotfiles and directories to home directory
    show_message "Updating dotfiles..." "$BLUE"
    cp -r "$HOME/Hyprland-blizz"/* ~/
    cp -r "$HOME/Hyprland-blizz"/.icons ~/
    cp -r "$HOME/Hyprland-blizz"/.Kvantum-themes ~/
    cp -r "$HOME/Hyprland-blizz"/.local ~/
    cp -r "$HOME/Hyprland-blizz"/Pictures ~/
    cp -r "$HOME/Hyprland-blizz"/.config ~/

    # Path to your welcome script
    welcome_script="$HOME/.config/hypr/scripts/hypr-welcome"

    echo "Hypr Welcome script installation complete."

    # Change directory to home
    cd "$HOME" || { show_message "Failed to change directory to home." "$RED"; exit 1; }

    # Path to the symlink in /usr/bin
    symlink="/usr/bin/hypr-welcome"

    # Check if the symlink exists
    if [ -L "$symlink" ]; then
        echo "Old symlink found. Removing..."
        sudo rm "$symlink" || { show_message "Failed to remove old symlink." "$RED"; exit 1; }
        echo "Old symlink removed."
    fi

    # Create new symlink
    echo "Creating new symlink..."
    echo "You may be prompted to enter your sudo password."
    # Prompt for sudo password
    sudo ln -sf "$welcome_script" "$symlink" || { show_message "Failed to create new symlink." "$RED"; exit 1; }
    echo "New symlink created."

    show_message "Dotfiles updated successfully." "$BLUE"
else
    show_message "You chose not to update your dotfiles." "$BLUE"
    # Notify the user about updates
    notify-send "Dotfiles update reminder" "There are pending updates for your dotfiles. Please consider updating."
fi

# Notify user about the end of the script
notify-send "We are done enjoy your updated Hyprland experience"
