xrandr --output Virtual-1 --mode 2560x1600
#xrandr --output Virtual-1 --mode 3840x2160
xrdb -merge ~/.Xresources

nitrogen --random --set-scaled
picom &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

fcitx5 -d

exec dwm
