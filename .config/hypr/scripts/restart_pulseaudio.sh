#!/bin/bash

# Script to restart PipeWire PulseAudio after resume from suspend or hibernate

# Check if PipeWire PulseAudio service is running
if systemctl --user is-active --quiet pipewire-pulse.service; then
    echo "PipeWire PulseAudio service is running."
else
    # Restart PipeWire PulseAudio service
    echo "Restarting PipeWire PulseAudio service..."
    systemctl --user restart pipewire-pulse.service
fi
