#!/bin/bash
# Directory for wallpapers
DIR="$HOME/Pictures/wallpapers-redblizard/"
CACHE_DIR="$HOME/.cache/awww"
CURRENT_CACHE="$CACHE_DIR/current_wallpaper.png"

# Wofi configuration paths for the wallpaper picker
WOFI_CONFIG="$HOME/.config/wofi/dmenu-launcher/config"
WOFI_STYLE="$HOME/.config/wofi/dmenu-launcher/style.css"

# Initialize or check if awww is running
mkdir -p "$CACHE_DIR"
if ! pgrep -x awww-daemon >/dev/null; then
    echo "Starting awww-daemon at $(date)" >> "$CACHE_DIR/wall_loop.log"
    awww-daemon & disown
fi

set_wallpaper() {
    local img="$1"
    # Change wallpaper using awww with transition effects
    awww img "$img" --transition-step 20 --transition-fps=20
    # Copy the selected wallpaper to cache for other tools (waybar, hyprlock)
    cp "$img" "$CURRENT_CACHE"
}

random_wp() {
    mapfile -t PICS < <(find "${DIR}" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \))
    [ ${#PICS[@]} -eq 0 ] && exit 1
    RANDOMPICS="${PICS[$RANDOM % ${#PICS[@]}]}"
    set_wallpaper "$RANDOMPICS"
}

select_wp() {
    # Wofi requires the specific 'img:<path>:text:<name>' syntax for dmenu icons
    # We pass a single space for text so it only renders the thumbnails (no filenames)
    CHOICE=$(find "${DIR}" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) | sort | while IFS= read -r f; do
        printf 'img:%s:text: \n' "$f"
    done | wofi --show dmenu \
                 --conf "$WOFI_CONFIG" \
                 --style "$WOFI_STYLE" \
                 --prompt "Select Wallpaper" \
                 --cache-file /dev/null)

    [ -z "$CHOICE" ] && exit 0

    # Extract the exact file path from the returned 'img:/path:text: ' string
    FULLPATH=$(echo "$CHOICE" | sed 's/^img:\(.*\):text:.*$/\1/')

    if [ -f "$FULLPATH" ]; then
        set_wallpaper "$FULLPATH"
    fi
}

case "${1:-}" in
    -s|--select) select_wp ;;
    *)           random_wp ;;
esac
