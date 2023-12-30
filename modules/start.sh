#!/usr/bin/env bash

# initialize wallpaper
hyprpaper --config ~/myConfiguration/modules/hyprpaper.conf &

# set wallpaper

#swww img ~/Wallpapers/wallpaper.png  &

# networkmanagerapplet

nm-applet --indicator &

# the bar

waybar -c ~/myConfiguration/dotfiles/waybar/config -s ~/myConfiguration/dotfiles/waybar/style.css &

# dunst

dunst
