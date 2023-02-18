#!/bin/bash

nitrogen --random --set-scaled ~/.wallpaper
picom &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

fcitx5 -d

bash ~/.scripts/refresh.sh &
