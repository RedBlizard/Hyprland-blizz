#!/bin/bash
sleep 1
awww-daemon &
sleep 0.5
awww img "$HOME/Imágenes/wallpapers/0027.jpeg" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-duration 1.0
