#!/bin/bash

# Sleep for a moment
sleep 1

# Kill the welcome app
pkill -f yad

# Function to update the system using yay in a terminal
update_system() {
    # Command to run inside the terminal
    local command="yay -Syu --noconfirm"

    # Determine the terminal emulator to use
    local terminal_emulator="kitty"  # Change this to "alacritty" if you prefer Alacritty

    # Check if the terminal emulator is available
    if ! command -v "$terminal_emulator" &> /dev/null; then
        echo "Error: $terminal_emulator is not installed or not found in PATH. Aborting."
        exit 1
    fi

    # Launch the terminal with the command
    echo "==> Launching $terminal_emulator to update the system..."

    # Run the command in the terminal, capturing output and return status
    local output=$($terminal_emulator -e bash -c "$command; exit_code=\$?; echo ''; if [ \$exit_code -eq 0 ]; then echo 'Press Enter to close this terminal window...'; read line; fi; exit \$exit_code")
    local exit_code=$?

    # Check if the terminal should be closed
    if [ $exit_code -eq 0 ]; then
        echo "==> Update completed successfully. Closing the terminal."
        sleep 2  # Delay to allow reading the final message
    else
        echo "==> Error occurred during update. Keeping the terminal open for review."
        echo "$output"
    fi

    return $exit_code
}

# Call the function to update the system
update_system

# Run the welcome script again after a short delay
bash "$HOME/.config/hypr/scripts/hypr-welcome" &

exit 0
