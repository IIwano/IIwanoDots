#!/bin/bash
img=$(find ~/Pictures/Fastfetch -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | shuf -n 1)

# Caja máxima en caracteres
max_w=36
max_h=18

# Proporción real de la imagen
read w h < <(magick identify -format "%w %h" "$img")

# Cada celda de la terminal es ~2 veces más alta que ancha
cols=$max_w
rows=$(( cols * h / (w * 2) ))
if [ "$rows" -gt "$max_h" ]; then
  rows=$max_h
  cols=$(( rows * 2 * w / h ))
fi

fastfetch --logo "$img" --logo-type kitty --logo-width "$cols" --logo-height "$rows"
