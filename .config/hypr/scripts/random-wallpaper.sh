#!/bin/bash
wallpaper=$(find ~/Pictures/Wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
~/.config/hypr/scripts/set-wallpaper.sh "$wallpaper"
