# Install inotify-tools if you haven't
sudo pacman -S inotify-tools

# Create a script to watch for changes in sourced files
while inotifywait -e modify ~/.config/hypr/conf/*.conf; do
    hyprctl reload
done

