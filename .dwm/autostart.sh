#!/bin/bash

nitrogen --random --set-scaled ~/.wallpaper
picom &

fcitx5 -d

bash ~/.scripts/refresh.sh &
