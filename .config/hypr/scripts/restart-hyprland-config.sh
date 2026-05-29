#!/bin/bash

# Reload systemd user service configuration
systemctl --user daemon-reload

# Restart the Hyprland config watcher service
systemctl --user restart hyprland-config-watcher.service

echo "Hyprland Config Watcher service restarted successfully."
