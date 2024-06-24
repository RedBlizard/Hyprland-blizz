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
folders=("alacritty" "btop" "cava" "dunst" "hypr" "kitty" "Kvantum" "networkmanager-dmenu" "nwg-look" "pacseek" "pipewire" "qt6ct" "ranger" "sddm-config-editor" "Thunar" "waybar" "wlogout" "wofi" "xsettingsd" "gtk-2.0" "gtk-3.0" "gtk-4.0" "starship" "swaync")

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
# Change to the dotfiles directory
cd "$HOME/Hyprland-blizz" || { show_message "Failed to change to dotfiles directory." "$RED"; exit 1; }

# Check if the current directory is a git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: Not inside a git repository or Git repository not initialized." >&2
    exit 1
fi

# Set GIT_DISCOVERY_ACROSS_FILESYSTEM if needed
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

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

# Get the commit hash before the pull (if it's the first time, $current_commit will be empty)
current_commit=$(git rev-parse HEAD)

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

# Function to check if the current directory is a git repository
is_git_repo() {
    if [ -d ".git" ]; then
        return 0  # It's a git repository
    else
        return 1  # It's not a git repository
    fi
}

# Function to send a notification using dunst
send_notification() {
    local message="$1"
    local urgency="$2"
    dunstify -p "$urgency" -u "$urgency" "$message"
}

# Check if the current directory is a git repository
if ! is_git_repo; then
    echo "Error: Not inside a git repository. Please run this script from within the Hyprland-blizz repository." >&2
    exit 1
fi

# Function to check for updates and generate notification if updates are available
check_updates() {
    # Fetch the latest changes from the remote repository
    git fetch origin main

    # Compare the local branch with the remote repository
    local commits_behind=$(git rev-list --count HEAD..origin/main)
    if [ "$commits_behind" -gt 0 ]; then
        # Updates are available
        send_notification "Updates are available for the dotfiles repository. Run the Hyprland welcome app to apply updates." "critical"
        return 0
    else
        # No updates available
        return 1
    fi
}

# Call the function to check for updates
if check_updates; then
    echo "Updates are available for the dotfiles repository."
else
    echo "No updates available for the dotfiles repository."
fi

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
else
    # If the user chooses not to update, exit the script
    echo "No dotfiles update performed."
    exit 0
fi


# Enable hypridle.service if not already enabled
if ! systemctl --user is-enabled hypridle.service >/dev/null 2>&1; then
    systemctl --user enable --now hypridle.service
fi

# Change to the home directory
cd "$HOME" || { echo 'Failed to change directory to home directory.'; exit 1; }

# Cleanup
rm -rf $HOME/README.md
rm -rf $HOME/sddm-images
rm -rf $HOME/LICENSE
rm -rf $HOME/sddm.conf

# Change to the scripts directory
cd "$HOME/.config/hypr/scripts" || { echo "Failed to change to the scripts directory." >&2; exit 1; }

# Function to check if all required symlinks exist
check_symlinks() {
    local symlinks=("hypr-welcome" "hypr-eos-kill-yad-zombies" "hypr_check_updates")
    local all_exist=true
    
    for symlink in "${symlinks[@]}"; do
        if [ ! -L "/usr/bin/$symlink" ]; then
            all_exist=false
            break
        fi
    done
    
    if $all_exist; then
        echo "All required symlinks exist."
        return 0
    else
        echo "Some symlinks are missing."
        return 1
    fi
}

# Check if the symlinks exist
if ! check_symlinks; then
    echo "Creating missing symlinks..."
    
    # Change to the scripts directory
    cd "$HOME/.config/hypr/scripts" || { echo "Failed to change to the scripts directory." >&2; exit 1; }

    # Path to your welcome script
    welcome_script="$HOME/.config/hypr/scripts/hypr-welcome"

    # Path to the symlink in /usr/bin
    symlink="/usr/bin/hypr-welcome"

    # Create new symlink
    sudo ln -sf "$welcome_script" "$symlink"


    # Path to your kill script
    kill_script="$HOME/.config/hypr/scripts/hypr-eos-kill-yad-zombies"

    # Path to the symlink in /usr/bin
    symlink="/usr/bin/hypr-eos-kill-yad-zombies"

    # Create new symlink
    sudo ln -sf "$kill_script" "$symlink"


    # Path to your update script
    update_script="$HOME/.config/hypr/scripts/hypr_check_updates.sh"

    # Path to the symlink in /usr/bin
    symlink="/usr/bin/hypr_check_updates"

    # Create new symlink
    sudo ln -sf "$update_script" "$symlink"
fi

# Set GNOME desktop interface settings using gsettings
# Gtk Theme workaround
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Frappe-Standard-Blue-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 10'
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 12'
gsettings set org.gnome.desktop.interface cursor-theme 'Qogir-dark'
gsettings set org.gnome.desktop.interface cursor-size '24'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'full'


# End of script

# Notify user about the end of the script
notify-send "We are done enjoy your updated Hyprland experience"
