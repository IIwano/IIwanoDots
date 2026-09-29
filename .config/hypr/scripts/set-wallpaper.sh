#!/bin/bash
wallpaper="$1"
awww img "$wallpaper" --transition-type wipe --transition-duration 1
matugen image "$wallpaper" -m dark
