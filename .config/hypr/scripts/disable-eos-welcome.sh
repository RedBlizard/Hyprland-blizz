#!/bin/bash

# Wait for any automatic startup of eos-welcome
sleep 5  # Adjust time as needed to let the welcome app start automatically

# Kill any instance of eos-welcome that may have started
pkill -f "eos-welcome"
