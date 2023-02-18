xrandr --output Virtual-1 --mode 2560x1600
#xrandr --output Virtual-1 --mode 3840x2160
xrdb -merge ~/.Xresources

exec dwm
