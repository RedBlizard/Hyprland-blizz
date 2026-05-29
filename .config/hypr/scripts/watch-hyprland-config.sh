#!/bin/bash
# watch-hyprland-config.sh - Stable, Optimized & Change-Logging for Hyprland 0.55+
sleep 3

CONFIG_DIR="$HOME/.config/hypr/modules"
HYPRLAND_MAIN="$HOME/.config/hypr/hyprland.lua"
LOG_FILE="$HOME/.config/hypr/scripts/hypr-reload.log"
CACHE_DIR="$HOME/.config/hypr/.watcher-cache"

mkdir -p "$CACHE_DIR" "$(dirname "$LOG_FILE")"

# 🛡️ Auto-clean log if it exceeds 50MB
if [ -f "$LOG_FILE" ]; then
    LOG_SIZE=$(stat -c%s "$LOG_FILE" 2>/dev/null || echo 0)
    [ "$LOG_SIZE" -gt 52428800 ] && > "$LOG_FILE"
fi

echo "$(date): Watcher started" >> "$LOG_FILE" 2>&1

if [ ! -f "$HYPRLAND_MAIN" ] || [ ! -d "$CONFIG_DIR" ]; then
    echo "$(date): ERROR - Config paths missing. Exiting." >> "$LOG_FILE" 2>&1
    exit 1
fi

# 📦 Initialize cache with current files
for f in "$HYPRLAND_MAIN" "$CONFIG_DIR"/*.lua; do
    [ -f "$f" ] || continue
    REL="${f#$HOME/.config/hypr/}"
    mkdir -p "$CACHE_DIR/$(dirname "$REL")"
    cp -f "$f" "$CACHE_DIR/$REL"
done

# ⏱️ Debounce (seconds)
DEBOUNCE=2
LAST_RELOAD=0

echo "$(date): Monitoring $HYPRLAND_MAIN & $CONFIG_DIR (with change logging)" >> "$LOG_FILE" 2>&1

# Watch for changes
inotifywait -m -e modify -e close_write "$HYPRLAND_MAIN" "$CONFIG_DIR" --format '%w%f' | while read -r FILE; do
    [[ "$FILE" == *.lua ]] || continue
    [[ -f "$FILE" ]] || continue

    NOW=$(date +%s)
    if (( NOW - LAST_RELOAD < DEBOUNCE )); then continue; fi

    # Determine cache path
    REL="${FILE#$HOME/.config/hypr/}"
    CACHE_FILE="$CACHE_DIR/$REL"

    echo "$(date): Change in $FILE → Reloading..." >> "$LOG_FILE" 2>&1

    # 📝 Log actual changed lines (max 5 for readability)
    if [ -f "$CACHE_FILE" ]; then
        CHANGES=$(diff -u0 "$CACHE_FILE" "$FILE" 2>/dev/null | grep -E "^[+-]" | grep -v "^---" | grep -v "^+++" | tail -n 5)
        if [ -n "$CHANGES" ]; then
            echo "   Modified lines:" >> "$LOG_FILE" 2>&1
            echo "$CHANGES" >> "$LOG_FILE" 2>&1
        else
            echo "   (No text diff detected - likely atomic editor save)" >> "$LOG_FILE" 2>&1
        fi
    fi

    # 🔄 Reload Hyprland
    /usr/bin/hyprctl reload >> "$LOG_FILE" 2>&1
    LAST_RELOAD=$NOW

    # 💾 Update cache
    mkdir -p "$(dirname "$CACHE_FILE")"
    cp -f "$FILE" "$CACHE_FILE"
done
