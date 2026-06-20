#!/bin/bash
CONFIG="$HOME/.config/wofi/cliphist-launcher/config"
STYLE="$HOME/.config/wofi/cliphist-launcher/style.css"
WOFI_CMD="wofi --show dmenu -c $CONFIG -s $STYLE"

if pgrep -x "wofi" > /dev/null; then
    pkill wofi
    exit 0
fi

# Stap 1: 3 items = columns=3 werkt perfect → horizontale buttons
ACTION=$(printf "📋  Copy\n🗑   Delete\n🧹  Clear All" | \
    wofi --show dmenu \
        -s "$STYLE" \
        --columns=3 \
        --width=950 \
        --height=342 \
        --prompt="Clipboard:")

# Stap 2: actie uitvoeren met history list
case "$ACTION" in
    "📋  Copy")
        cliphist list | $WOFI_CMD -p "Select to Copy:" | cliphist decode | wl-copy
        notify-send "Clipboard" "Item copied" -t 1500
        ;;
    "🗑   Delete")
        cliphist list | $WOFI_CMD -p "Select to Delete:" | cliphist delete
        notify-send "Clipboard" "Item deleted" -t 1500
        ;;
    "🧹  Clear All")
        confirm=$(printf "Yes\nNo" | $WOFI_CMD -p "Clear all history?")
        [ "$confirm" == "Yes" ] && cliphist wipe && notify-send "Clipboard" "History cleared" -t 1500
        ;;
    *)
        exit 0
        ;;
esac
