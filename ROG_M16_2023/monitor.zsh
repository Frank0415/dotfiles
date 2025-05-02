#!/bin/zsh

function usage() {
    echo ""
    echo "Usage: $0 [-on|-off] [-DP-2|-HDMI-0]"
    exit 1
}

HDMI_STATE=""
WACOM_OUTPUT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -on)
            HDMI_STATE="on"
            ;;
        -off)
            HDMI_STATE="off"
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
    xrandr --output HDMI-0 --auto --pos 3840x-280 --scale 1.25 &
    $HOME/.config/polybar/launch.sh &
elif [[ $HDMI_STATE == "off" ]]; then
    xrandr --output HDMI-0 --off &
    $HOME/.config/polybar/launch.sh &
fi

if [[ $WACOM_OUTPUT == "DP-2" || $WACOM_OUTPUT == "HDMI-0" ]]; then
    xsetwacom MapToOutput "Wacom One by Wacom M Pen stylus" $WACOM_OUTPUT
    xsetwacom set "Wacom One by Wacom M Pen stylus" Button2 "key +ctrl z -ctrl"
    xsetwacom set "Wacom One by Wacom M Pen stylus" Button3 "key +Shift +ctrl p -ctrl -Shift"
    xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 0 0 100
    xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 100 100 100
fi