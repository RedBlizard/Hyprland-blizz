#!/bin/bash

# Define color codes
RED='\033[0;31m'
BLUE='\033[1;34m'
GREEN='\033[38;2;149;209;137m'
NC='\033[0m' # No Color

# Function to launch an Alacritty terminal if not already launched
launch_alacritty_terminal() {
    # Check if the current terminal is already Alacritty
    if [ -z "$ALACRITTY_WINDOW_ID" ]; then
        # If not, attempt to launch Alacritty
        if ! alacritty -e "$0" &>/dev/null; then
            # If Alacritty fails to launch, display an error message
            echo -e "${RED}Failed to launch Alacritty. Please check your Alacritty installation or configuration.${NC}"
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
backup_dir="$HOME/.config/backup"
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
    folder_path="$HOME/.config/$folder"
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

# Change to the dotfiles directory
cd "$HOME/Hyprland-blizz" || { echo -e "${RED}Failed to change to dotfiles directory.${NC}"; exit 1; }

echo -e "${RED}░█─░█ █──█ █▀▀█ █▀▀█ █── █▀▀█ █▀▀▄ █▀▀▄ 　 █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀ 　 █──█ █▀▀█ █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀${NC}" 
echo -e "${RED}░█▀▀█ █▄▄█ █──█ █▄▄▀ █── █▄▄█ █──█ █──█ 　 █──█ █──█ ──█── ▀▀█ 　 █──█ █──█ █──█ █▄▄█ ──█── █▀▀${NC}" 
echo -e "${RED}░█─░█ ▄▄▄█ █▀▀▀ ▀─▀▀ ▀▀▀ ▀──▀ ▀──▀ ▀▀▀─ 　 ▀▀▀─ ▀▀▀▀ ──▀── ▀▀▀ 　 ─▀▀▀ █▀▀▀ ▀▀▀─ ▀──▀ ──▀── ▀▀▀${NC}"
# Add two empty rows
echo
echo

# Function to check for updates and generate notification if updates are available
check_updates() {
    # Fetch the latest changes from the remote repository
    git fetch origin main

    # Compare the local branch with the remote repository
    local commits_behind=$(git rev-list --count HEAD..origin/main)
    if [ "$commits_behind" -gt 0 ]; then
        # Updates are available
        echo -e "${RED}Updates are available for the dotfiles repository. Run the Hyprland welcome app to apply updates!.${NC}"
        send_notification "Updates are available for the dotfiles repository. Run the Hyprland welcome app to apply updates." "critical"
        return 0
    else
        # No updates available
        return 1
    fi
}

# Function to send a notification using dunst with different urgencies
send_notification() {
    local message="$1"
    local urgency="$2"
    dunstify -p "$urgency" -u "$urgency" "$message"
}

# Function to clone or update the dotfiles repository
clone_or_update_dotfiles_repository() {
    # Check if the dotfiles directory exists
    if [ ! -d "$HOME/Hyprland-blizz" ]; then
        # Clone the dotfiles repository
        echo -e "${BLUE}Now we are getting in the dotfiles. Please be patient, this might take a while depending on your internet speed!${NC}"
        echo -e "${BLUE}Cloning dotfiles repository...${NC}"
        git clone "https://github.com/RedBlizard/Hyprland-blizz.git" "$HOME/Hyprland-blizz" || { echo -e "${RED}Failed to clone dotfiles repository.${NC}"; exit 1; }
    else
        # Change to the dotfiles directory
        cd "$HOME/Hyprland-blizz" || { echo -e "${RED}Failed to change to dotfiles directory.${NC}"; exit 1; }

        # Pull the latest changes from the dotfiles repository
        echo -e "${BLUE}Pulling the latest changes from the dotfiles repository...${NC}"
        git pull origin main || { echo -e "${RED}Failed to pull dotfiles repository.${NC}"; exit 1; }
    fi
}

# Check if the dotfiles repository needs to be cloned or updated
if [ ! -d "$HOME/Hyprland-blizz" ]; then
    # Dotfiles directory doesn't exist, clone the repository
    clone_or_update_dotfiles_repository
else
    # Change to the dotfiles directory
    cd "$HOME/Hyprland-blizz" || { echo -e "${RED}Failed to change to dotfiles directory.${NC}"; exit 1; }

    # Check if the repository is already up to date
    if git pull --dry-run origin main | grep -q 'Already up to date'; then
        echo -e "${BLUE}Dotfiles repository is already up to date.${NC}"
    else
        # Ask the user if they want to clone the dotfiles repository again to apply updates
        read -p "The dotfiles repository is not up to date. Do you want to clone it again to apply updates? (Y/N): " update_choice
        case "$update_choice" in
            [Yy]* )
                # Update the dotfiles repository
                clone_or_update_dotfiles_repository
                ;;
            * )
                # User chose not to update, continue
                echo -e "${BLUE}Continuing without updating dotfiles.${NC}"
                ;;
        esac
    fi
fi

# Function to check for updates and generate notification if updates are available
check_updates

# Reminder loop if user chooses not to clone immediately
reminder_count=0
while true; do
    # Increment reminder count
    ((reminder_count++))

    # Set default urgency to normal
    urgency="normal"

    # Update urgency based on reminder count
    if [ $reminder_count -ge 3 ]; then
        urgency="critical"
    elif [ $reminder_count -eq 2 ]; then
        urgency="high"
    elif [ $reminder_count -eq 1 ]; then
        urgency="normal"
    fi

    # Check for updates
    if check_updates; then
        # If updates are available, remind the user to apply updates
        send_notification "Updates are still available for the dotfiles repository. Run the Hyprland welcome app to apply updates." "$urgency"
    fi

    # Sleep for 1 hour
    sleep 3600
done

# Change to the dotfiles directory
cd "$HOME/Hyprland-blizz" || { echo -e "${RED}Failed to change to dotfiles directory.${NC}"; exit 1; }

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
