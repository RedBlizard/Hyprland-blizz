#!/bin/bash

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
SCRIPT_DIR="$HOME/Hyprland-blizz"
cd "$SCRIPT_DIR" || { echo 'Failed to change directory to script directory.'; exit 1; }

RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${RED}░█─░█ █──█ █▀▀█ █▀▀█ █── █▀▀█ █▀▀▄ █▀▀▄ 　 █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀ 　 █──█ █▀▀█ █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀${NC}" 
echo -e "${RED}░█▀▀█ █▄▄█ █──█ █▄▄▀ █── █▄▄█ █──█ █──█ 　 █──█ █──█ ──█── ▀▀█ 　 █──█ █──█ █──█ █▄▄█ ──█── █▀▀${NC}" 
echo -e "${RED}░█─░█ ▄▄▄█ █▀▀▀ ▀─▀▀ ▀▀▀ ▀──▀ ▀──▀ ▀▀▀─ 　 ▀▀▀─ ▀▀▀▀ ──▀── ▀▀▀ 　 ─▀▀▀ █▀▀▀ ▀▀▀─ ▀──▀ ──▀── ▀▀▀${NC}"
# Add two empty rows
echo
NC='\033[0m' # No Color

# Function to clone or pull the dotfiles repository
clone_or_pull_repository() {
    # Check if the dotfiles directory exists
    if [ ! -d "$HOME/Hyprland-blizz" ]; then
        # Dotfiles directory doesn't exist, so clone the repository
        read -p "Dotfiles repository doesn't exist. Do you want to clone it? please answer with 'Y' for yes and 'N' for no (Yy/Nn): " choice
        case "$choice" in
            [Yy]* )
                # Clone the dotfiles repository
                echo "Cloning dotfiles repository..."
                if ! git clone "https://github.com/RedBlizard/Hyprland-blizz.git" "$HOME/Hyprland-blizz"; then
                   dunstify -p 1 -u critical "Failed to clone dotfiles repository."
                   exit 1
                fi
                ;;
            * )
                echo "Exiting..."
                exit 0
                ;;
        esac
    else
        # Change to the dotfiles directory
        cd "$HOME/Hyprland-blizz" || { echo "Failed to change to dotfiles directory."; exit 1; }

        # Pull the latest changes from the dotfiles repository
        echo "Pulling the latest changes from the dotfiles repository..."
        if git pull origin main; then
            echo "Dotfiles repository is up to date."
            # Execute the function to check for updates
            check_updates
        else
            echo "Failed to pull dotfiles repository."
            exit 1
        fi
    fi
}

# Execute the function to clone or pull the repository
clone_or_pull_repository

# Function to check for updates and generate notification if updates are available
check_updates() {
    # Fetch the latest changes from the remote repository
    git fetch

    # Compare the local branch with the remote repository
    if [ $(git rev-list HEAD...origin/main --count) -gt 0 ]; then
        # Updates are available
        echo "Updates are available for the dotfiles repository." | dunstify -p 1 -u critical
        return 0
    else
        # No updates available
        return 1
    fi
}

# Infinite loop to check for updates periodically
while true; do
    # Execute the check every 5 minutes (300 seconds)
    sleep 300
    check_updates
done

# Ask the user if they want to update dotfiles
read -rp "Do you want to update your dotfiles? (Enter 'Y' for yes or 'N' for no): (Yy/Nn): " update_choice

if [ "$update_choice" == "y" ] || [ "$update_choice" == "Y" ]; then
    # Copy dotfiles and directories to home directory
    show_message "Updating dotfiles..." "$BLUE"
    cp -r "$HOME/Hyprland-blizz"/* ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
    cp -r "$HOME/Hyprland-blizz"/.icons ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
    cp -r "$HOME/Hyprland-blizz"/.Kvantum-themes ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
    cp -r "$HOME/Hyprland-blizz"/.local ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
    cp -r "$HOME/Hyprland-blizz"/Pictures ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
    cp -r "$HOME/Hyprland-blizz"/.config ~/ || { show_message "Failed to update dotfiles." "$RED"; exit 1; }
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
notify-send --urgency=normal "We are done enjoy your updated Hyprland experience"
