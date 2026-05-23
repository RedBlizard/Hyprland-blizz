#!/bin/bash

# Wait for any automatic startup of eos-welcome
sleep 5

# Only kill if it's actually running
if pgrep -x eos-welcome >/dev/null 2>&1; then
    pkill -x eos-welcome
fi
