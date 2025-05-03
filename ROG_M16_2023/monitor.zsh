#!/bin/zsh

function usage() {
    echo ""
    echo "Usage: $0 [-on|-off] [-lapon|-lapoff] [-DP-2|-HDMI-0]"
    exit 1
}

HDMI_STATE=""
WACOM_OUTPUT=""
LAPTOP_STATE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -on)
            HDMI_STATE="on"
            ;;
        -off)
            HDMI_STATE="off"
            ;;
	    -lapoff)
            LAPTOP_STATE="off"
            ;;
        -lapon)
            LAPTOP_STATE="on"
            ;;
        -DP-2)
            WACOM_OUTPUT=DP-2
            ;;
        -HDMI-0)
            WACOM_OUTPUT=HDMI-0
            ;;
        *)
            usage
            ;;
    esac
    shift
done

if [[ -z $HDMI_STATE && -z $WACOM_OUTPUT ]]; then
    usage
fi

if [[ $HDMI_STATE == "on" ]]; then
    $HOME/.config/polybar/launch.sh &
    nitrogen --restore &
elif [[ $HDMI_STATE == "off" ]]; then
    xrandr --output HDMI-1-0 --off &
    $HOME/.config/polybar/launch.sh &
    nitrogen --restore &
fi

if [[ $LAPTOP_STATE == "on" ]]; then
    xrandr --output DP-2 --auto --scale 1.5 &
    $HOME/.config/polybar/launch.sh &
    nitrogen --restore &
elif [[ $LAPTOP_STATE == "off" ]]; then
    xrandr --output DP-2 --off &
    xrandr --output HDMI-1-0 --auto --pos 3840x-280 --scale 1.25 &
    $HOME/.config/polybar/launch.sh &
    nitrogen --restore &
fi

if [[ $WACOM_OUTPUT == "DP-2" || $WACOM_OUTPUT == "HDMI-0" || $WACOM_OUTPUT == "eDP-1" ]]; then
    xsetwacom MapToOutput "Wacom One by Wacom M Pen stylus" $WACOM_OUTPUT
    xsetwacom set "Wacom One by Wacom M Pen stylus" Button2 "key +ctrl z -ctrl"
    xsetwacom set "Wacom One by Wacom M Pen stylus" Button3 "key +Shift +ctrl p -ctrl -Shift"
    xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 0 0 100
    xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 100 100 100
fi
ra