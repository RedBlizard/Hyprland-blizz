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
    # Change to the dotfiles directory
    cd "$HOME/Hyprland-blizz" || { show_message "Failed to change to dotfiles directory." "$RED"; exit 1; }

    # Pull the latest changes from the dotfiles repository
    show_message "Pulling the latest changes from the dotfiles repository..." "$BLUE"
    if ! git pull origin main; then
        show_message "Failed to pull dotfiles repository." "$RED"
        exit 1
    fi

    # Get the commit hash after the pull
    new_commit=$(git rev-parse HEAD)
fi

# Get the commit hash before the pull (if it's the first time, $current_commit will be empty)
current_commit=$(git rev-parse HEAD)

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
cd "$HOME/Hyprland-blizz" || { show_message "Failed to change to dotfiles directory." "$RED"; exit 1; }

# Ask the user if they want to update dotfiles
read -rp "Do you want to update your dotfiles? (Enter 'Yy' for yes or 'Nn' for no): (Yy/Nn): " update_choice

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
notify-send "We are done enjoy your updated Hyprland experience"
