#!/bin/bash
if rfkill list bluetooth | grep -q 'Soft blocked: yes'; then
    rfkill unblock bluetooth && notify-send 'Bluetooth enabled'
else
    rfkill block bluetooth && notify-send 'Bluetooth disabled'
fi
