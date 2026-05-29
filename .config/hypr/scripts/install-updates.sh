#!/bin/bash
# Update system: AUR (yay) + Flatpak
echo "=== System update ==="
yay -Syu --noconfirm
echo ""
echo "=== Flatpak update ==="
flatpak update -y
echo ""
echo "All done!"
