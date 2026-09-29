#!/bin/bash
wallpaper=$(find ~/Pictures/Wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r img; do
  name=$(basename "$img")
  echo -e "$name\0icon\x1f$img"
done | rofi -dmenu -i -p "Wallpaper" -show-icons \
  -theme-str 'element-text { enabled: false; } element-icon { size: 280px; } element { padding: 2px; margin: 2px; } listview { columns: 3; lines: 2; spacing: 4px; } window { width: 950px; }')
[ -z "$wallpaper" ] && exit

selected=$(find ~/Pictures/Wallpapers -type f -iname "$wallpaper")
~/.config/hypr/scripts/set-wallpaper.sh "$selected"
