#!/usr/bin/fish

set config_dir $HOME/.config/hypr/conf
set hyprland_config $HOME/.config/hypr/hyprland.conf

echo "Script started" >> $HOME/.config/hypr/scripts/hypr-reload.log 2>&1

# Find all .conf files in the config directory and include hyprland.conf
set conf_files (find $config_dir -type f -name "*.conf")
set all_files $conf_files $hyprland_config

# Log which files are being watched
echo "Watching: $all_files" >> $HOME/.config/hypr/scripts/hypr-reload.log 2>&1

while true
    # Use inotifywait with the found .conf files including hyprland.conf
    inotifywait -e modify $all_files
    echo "Change detected! Attempting to reload Hyprland..." >> $HOME/.config/hypr/scripts/hypr-reload.log 2>&1
    /usr/bin/hyprctl reload >> $HOME/.config/hypr/scripts/hypr-reload.log 2>&1
end
