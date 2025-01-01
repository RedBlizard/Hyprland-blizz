#!/bin/bash

# Extract all active keymap entries
layout=$(hyprctl devices | grep "active keymap:" | awk '{print $3}' | tr -d '()' | uniq)

# Map the layout to language labels
case "$layout" in
    "English")
        echo " US ⠀⠀"
        ;;
    "Dutch")
        echo " NL ⠀⠀"
        ;;
    "Spanish")
        echo " ES ⠀⠀"
        ;;
    "German")
        echo " DE ⠀⠀"
        ;;
    "Russian")
        echo " RU ⠀⠀"
        ;;
    *)
        echo " Unknown ⠀⠀"
        ;;
esac
