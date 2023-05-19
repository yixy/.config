xrandr --output DP-3-1 --mode 3840x2160
xrandr --output DP-3-8 --mode 3840x2160
xrandr --output HDMI-1 --mode 1680x1050
xrandr --output HDMI-2 --mode 1680x1050
#xrandr --output HDMI-2 --mode 1920x1080

if [ $(xrandr | grep "current 3840 x 2160" |wc -l) == '1' ]
then
  xrdb -merge ~/.Xresources
fi

#xinput set-prop 11 309 1
#xinput set-prop 11 301 1

exec dwm
