#!/bin/bash

# Function to show a message with color
show_message() {
    local message="$1"
    local color="$2"
    echo -e "${color}${message}${NC}"
}

# Function to launch an Alacritty terminal if not already launched
launch_alacritty_terminal() {
    # Check if the current terminal is already Alacritty
    if [ -z "$ALACRITTY_WINDOW_ID" ]; then
        # If not, attempt to launch Alacritty
        if ! alacritty -e "$0" &>/dev/null; then
            # If Alacritty fails to launch, display an error message
            echo "Failed to launch Alacritty. Please check your Alacritty installation or configuration."
            exit 1
        fi
        # Exit the script after launching Alacritty
        exit
    fi
}

# Call the function to launch Alacritty terminal
launch_alacritty_terminal

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

# Ensure the script is in the correct directory
cd "$HOME/Hyprland-blizz" || { echo 'Failed to change directory to dotfiles directory.'; exit 1; }

# Check for updates from GitHub repository
show_message "Checking for updates from GitHub repository..." "$BLUE"
if git fetch origin main &>/dev/null; then
    # Get the commit hash before the fetch
    current_commit=$(git rev-parse HEAD)
    # Perform the fetch
    git fetch origin main &>/dev/null
    # Get the commit hash after the fetch
    new_commit=$(git rev-parse HEAD)

    # Check if there are updates
    if [ "$current_commit" != "$new_commit" ]; then
        show_message "Updates found. Notifying user..." "$BLUE"
        # Send a dunst notification about available updates
        dunstify -u low "Reminder: Dotfile updates available" "There are updates available for your dotfiles. Would you like to update now? Run the script with the '--update-now' option to update immediately." -a "update_dotfiles" -r 99999
        exit 0
    else
        show_message "No updates found for dotfiles." "$BLUE"
    fi
else
    show_message "Failed to check for updates from GitHub repository." "$RED"
fi


BLUE='\033[0;38;5;38m'
NC='\033[0m' # No Color

# If user chooses to update now
if [ "$1" == "--update-now" ]; then
    # Pull the latest changes from GitHub repository
    show_message "Pulling changes from GitHub repository..." "$BLUE"
    echo -e "${BLUE}Pulling changes from GitHub repository....${NC}"
    if git -C "$HOME/Hyprland-blizz" pull origin main; then
        show_message "Hyprland, desktop portal, and Waybar have been updated." "$BLUE"
        # Ensure the script is in the correct directory
        # Copy dotfiles and directories to home directory
        cd "$HOME/Hyprland-blizz" || { echo 'Failed to change directory to home directory.'; exit 1; }        
        show_message "Updating dotfiles..." "$BLUE"
        cp -r "$HOME/Hyprland-blizz"/* ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
        cp -r "$HOME/Hyprland-blizz"/.local ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
        cp -r "$HOME/Hyprland-blizz"/Pictures ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
        cp -r "$HOME/Hyprland-blizz"/.config ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
        # Notify user about the end of the update process
        notify-send "Dotfiles updated" "Your dotfiles have been successfully updated."
    else
        show_message "Failed to pull updates from GitHub repository." "$RED"
    fi
else
    # If user chooses to update later, set up a periodic reminder
    while true; do
        show_message "Checking for updates from GitHub repository..." "$BLUE"
        if git -C "$HOME/Hyprland-blizz" fetch origin main; then
            # Get the commit hash before the fetch
            current_commit=$(git -C "$HOME/Hyprland-blizz" rev-parse HEAD)
            # Perform the fetch
            git -C "$HOME/Hyprland-blizz" fetch origin main
            # Get the commit hash after the fetch
            new_commit=$(git -C "$HOME/Hyprland-blizz" rev-parse HEAD)

            # Check if there are updates
            if [ "$current_commit" != "$new_commit" ]; then
                show_message "Reminder: Dotfile updates available" "$BLUE"
                dunstify -u low "Reminder: Dotfile updates available" "There are updates available for your dotfiles. Would you like to update now? Run the script with the '--update-now' option to update immediately." -a "update_dotfiles" -I "$HOME/.config/hypr/icons/hypr-icon.png" -r 99999
                sleep 1800 # Sleep for 30 minutes
            fi
        else
            show_message "Failed to check for updates from GitHub repository." "$RED"
        fi
        sleep 1800 # Sleep for 30 minutes
    done
fi

# Change to the home directory
cd "$HOME" || { echo 'Failed to change directory to home directory.'; exit 1; }

# Cleanup
rm -rf $HOME/README.md
rm -rf $HOME/sddm-images
rm -rf $HOME/LICENSE

# Path to your welcome script
welcome_script="$HOME/.config/hypr/scripts/hypr-welcome"

# Path to the symlink in /usr/bin
symlink="/usr/bin/hypr-welcome"

# Check if the symlink exists and remove it if it does
if [ -L "$symlink" ]; then
    echo "Old symlink found. Removing..."
    # Remove the old symlink without prompting for a password
    echo "$USER ALL=(ALL) NOPASSWD: /bin/rm $symlink" | sudo EDITOR='tee -a' visudo >/dev/null
    sudo rm "$symlink" && echo "Old symlink removed." || echo "Failed to remove old symlink."
fi

# Create new symlink without prompting for a password
echo "Creating new symlink..."
echo "You may be prompted to enter your sudo password."
echo "$USER ALL=(ALL) NOPASSWD: /bin/ln -sf $welcome_script $symlink" | sudo EDITOR='tee -a' visudo >/dev/null
sudo ln -sf "$welcome_script" "$symlink" && echo "New symlink created." || echo "Failed to create new symlink."

echo "Hypr-welcome script installation complete."

# Notify user about the end of the script
notify-send "We are done enjoy your updated Hyprland experience"
