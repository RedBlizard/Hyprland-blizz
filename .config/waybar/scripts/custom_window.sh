#!/bin/bash

# Function to get active window title
get_active_window_title() {
    # Use the `xdotool` command to get the active window title
    active_window_title=$(xdotool getactivewindow getwindowname)
    echo "$active_window_title"
}

# Function to format the window title according to provided rules
format_window_title() {
    # Read the window title from the function argument
    window_title="$1"

    # Apply the rewriting rules specified in the configuration
    formatted_title="$window_title"
    formatted_title="${formatted_title// - Brave/}"         # Remove "- Brave"
    formatted_title="${formatted_title// - Brave Search/}"  # Remove "- Brave Search"
    formatted_title="${formatted_title// - fish/> [$1]}"   # Rewrite "- fish" as "> [Title]"
    formatted_title="${formatted_title// - Outlook/}"      # Remove "- Outlook"

    echo "$formatted_title"
}

# Main function
main() {
    # Get the active window title
    active_window=$(get_active_window_title)

    # Format the window title
    formatted_window_title=$(format_window_title "$active_window")

    # Output the formatted window title as JSON
    echo "{ \"text\": \"$formatted_window_title\" }"
}

# Call the main function
main
