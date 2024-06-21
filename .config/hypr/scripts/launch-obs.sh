#!/bin/bash

# Log the date and time of script execution
echo "Launching OBS Studio at $(date)" >> /tmp/obs-launch-log.txt

# Launch OBS Studio
obs &>> /tmp/obs-launch-log.txt

