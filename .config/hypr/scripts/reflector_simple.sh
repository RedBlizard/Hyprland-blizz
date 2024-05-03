#!/bin/bash

# Step 1: Start reflector-simple
reflector-simple &

# Store the PID of reflector-simple
reflector_pid=$!

# Step 2: Kill yad (hypr-welcome)
pkill -f yad

# Step 3: Check if reflector-simple is closed
while kill -0 $reflector_pid 2>/dev/null; do
    sleep 1
done

# Step 4: Restart hypr-welcome
hypr-welcome &
