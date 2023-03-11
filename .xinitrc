xrandr --output Virtual-1 --mode 2560x1600

xrdb -merge ~/.Xresources

xinput set-prop 11 309 1
xinput set-prop 11 301 1

exec dwm
